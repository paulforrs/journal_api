Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  resources :categories, only: [:create, :show]
  resources :users do
    resources :tasks
    resources :categories
  end
  post 'auth/signup' => 'auth#signup'
  post 'auth/signin' => 'auth#signin'

end
