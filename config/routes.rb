ActionController::Routing::Routes.draw do |map|
  

    
map.resources :groups, :friends, :users, :bull_positions
map.resource :session
map.resources :entrants, :collection => { :select_square => :get, :update_square => :put, :confirmation => :get, :invited => :get }


  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  
  map.root :controller => "game"
  map.home 'home', :controller => "home", :action => "index"


  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.connect 'terms', :controller=>"html",:action=>"terms"
    
  # admin routes
  map.news '/admin/news', :controller => 'admin', :action => 'news'

end
