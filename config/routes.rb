ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => "activate"
  
  map.brochure '/pages/*page', :controller => "brochure"
  map.resources :forgotten_passwords
  
  map.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }

  map.resource :session

  map.root :controller => 'users', :action => :index
end
