Rails.application.routes.draw do
  resources :signups

  devise_for :users
  resources :users
  
  root 'static_pages#landingpg'
  # root 'static_pages#homepg'
  # get     'landing-page',                   to: 'static_pages#landingpg'
end
