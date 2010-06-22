namespace :db do
  desc "Bootstrap your database for Spree."
  task :bootstrap  => :environment do
    # load initial database fixtures (in db/sample/*.yml) into the current environment's database
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
    Dir.glob(File.join(StaticContentExtension.root, "db", 'sample', '*.{yml,csv}')).each do |fixture_file|
      Fixtures.create_fixtures("#{StaticContentExtension.root}/db/sample", File.basename(fixture_file, '.*'))
    end

  end
end

namespace :spree do
  namespace :extensions do
    namespace :static_content do
      desc "Copies public assets of the Static Content to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[StaticContentExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(StaticContentExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end