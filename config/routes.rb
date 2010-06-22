# Put your extension routes here.

map.namespace :admin do |admin|
  admin.resources :pages
end
map.static '/static/*path', :controller => 'content', :action => 'show'

