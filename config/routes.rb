Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  resources :categories
  resources :users, defaults: {format: :json} do
    resources :tasks do 
      resources :categories, only: [:show, :index]
    end
    resources :categories
  end
  post 'auth/signup' => 'auth#signup'
  post 'auth/signin' => 'auth#signin'

end
