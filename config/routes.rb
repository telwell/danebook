Rails.application.routes.draw do
  
  # Set the root URL to the user new page so users can sign up
  # or create an account.
  root 'users#new'
  
  resources :users, :only => [:new, :create]

  # There's only one profile associated with an
	# individual user (and no need for an index page)
	# so this will be a singular resource. I originally 
	# nested this under :users but I don't think there's
	# really a need for that now.
	resources :profiles, :only => [:show, :edit, :create, :update] do
    resource :posts, :only => [:show, :create, :destroy]
    resources :friendships, :only => [:create, :destroy]
  end

  resource :session, :only => [:create, :destroy]

  # Only need to create/destroy likes and comments FOR NOW!
  resources :likes, :only => [:create, :destroy]
  resources :comments, :only => [:create, :destroy]


  # These are going to go eventually but will stay for now.
  # TODO: Delete these puppies.
  get 'static_pages' => 'static_pages#index'
  get 'static_pages/:page' => 'static_pages#index'
end
