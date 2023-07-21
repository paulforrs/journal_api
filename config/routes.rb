Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  resources :categories
  resources :tasks
  resources :users
  post 'users/create' => 'users#create'
  delete 'users/delete' => 'users#destroy'
  post 'auth/signup' => 'auth#signup'
  post 'auth/signin' => 'auth#signin'

end
