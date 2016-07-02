Rails.application.routes.draw do
  resources :signups

  devise_for :users
  
  root 'static_pages#homepg'
  get     'landing-page',                   to: 'static_pages#landingpg'
end
