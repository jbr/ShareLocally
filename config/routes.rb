ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => "activate"
  
  map.brochure '/pages/*page', :controller => "brochure"
  
  map.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete } do |user|
    user.resources :items
  end
  
  map.resources :requests
    
  map.resources :items do |item|
    item.resources :requests
  end

  map.resource :session

  map.root :controller => 'users', :action => :index
end
