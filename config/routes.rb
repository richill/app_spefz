Rails.application.routes.draw do
  resources :socials
  resources :events
  resources :signups
  resources :relationships, only: [:create, :destroy]

  # devise_for :users
  # resources :users do
  #   resources :socials
  # end
  
  # root 'static_pages#homepg'
  root 'static_pages#landingpg'
  # get  'landing-page',                   to: 'static_pages#landingpg'
  get  'home-page',                   to: 'static_pages#homepg'
end

