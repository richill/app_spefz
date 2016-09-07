Rails.application.routes.draw do
  resources :socials
  resources :events
  resources :signups
  resources :relationships, only: [:create, :destroy]
  resources :friendships,   only: [:create, :destroy]

  devise_for :users
  resources :users do
    resources :socials
  end
  
  root  'static_pages#homepg'
  get   'landing-page',             to: 'static_pages#landingpg'
  get   'tags/:tag',                to: 'users#index', as: :tag
end

