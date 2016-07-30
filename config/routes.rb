Rails.application.routes.draw do
  root 'static_pages#home'

  # static pages routes, not connected to models
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # dynamic routes
  get '/signup', to: 'users#new'
  get '/products', to: 'products#index'
  get '/products/new', to: 'products#new'

  get '/categories', to: 'categories#index'
  get '/categories/new', to: 'categories#new'

  # login routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  # restful routes
  resources :users, except: [ :new ]
  resources :products
  resources :categories

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
