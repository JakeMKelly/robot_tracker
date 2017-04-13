Rails.application.routes.draw do
  get 'welcome/index'

  root "portals#open"

  get '/open', to: 'portals#open', as: 'open_portal'
  get '/closed', to: 'portals#closed', as: 'closed_portal'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

  resources :manufacturers, only: :index, shallow: true do
    resources :models, only: :index do
      resources :robots, only: :create
    end
  end

  resources :users, except: :index

  resources :robots, except: [:create, :new]

  get '/products', to: 'products#index'
  get '/products/:id', to: 'products#show', as: 'product'
  post '/products/:id/charges', to: 'charges#create', as: 'charges'

end
