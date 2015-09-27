Rails.application.routes.draw do
  
  # Set the root URL to the user new page so users can sign up
  # or create an account.
  root 'users#new'
  
  resources :users, :only => [:new, :create, :update]

  # There's only one profile associated with an
	# individual user (and no need for an index page).
	resources :profiles, :only => [:show, :edit, :create, :update] do
    resource :posts, :only => [:show, :create, :destroy]
    resource :search, :only => [:show]
    resource :newsfeed, :only => [:show]
    resources :friendships, :only => [:create, :destroy, :index]
    resources :photos, :only => [:index, :new, :create, :show, :destroy]
  end


  # Only need to create/destroy sessions, likes, and comments FOR NOW!
  resource :session, :only => [:create, :destroy]
  resources :likes, :only => [:create, :destroy]
  resources :comments, :only => [:create, :destroy]


  # These are going to go eventually but will stay for now.
  # TODO: Delete these puppies.
  get 'static_pages' => 'static_pages#index'
  get 'static_pages/:page' => 'static_pages#index'
end
