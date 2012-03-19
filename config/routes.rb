Packager::Application.routes.draw do
  get "package/index"
  get "package/list_stable" => "package#list_stable"
  get "package/list_trunk" => "package#list_trunk"
  
  post "package/upload" => "package#upload"
  post "package/upload_stable" => "package#upload_stable"
  post "package/upload_trunk" => "package#upload_trunk"
  
  root :to => "package#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
