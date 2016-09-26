Rails.application.routes.draw do
  resources :socials
  resources :events
  resources :signups
  resources :relationships, only: [:create, :destroy]
  resources :friendships,   only: [:create, :destroy]

  devise_for :users
  resources :users do
    resources :comments, only: [:create, :destroy] 
    resources :socials
  end

  resources :socials do
    resources :comments, only: [:create, :destroy] 
  end
  
  root  'static_pages#homepg'
  get   'landing-page',             to: 'static_pages#landingpg'
  get   'tags/:tag',                to: 'users#index', as: :tag
  get   'socialtags/:tag',          to: 'socials#index', as: :social_tag
end

