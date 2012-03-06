Multitenants::Application.routes.draw do
  match '', to: 'tenants#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  resources :subjects
  resources :tenants
  root :to => 'tenants#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
