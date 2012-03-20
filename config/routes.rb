Packager::Application.routes.draw do
  get "package/index"
  get "package/list_stable" => "package#list"
  post "package/upload" => "package#upload"
  root :to => "package#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
