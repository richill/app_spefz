Rails.application.routes.draw do
  resources :signups

  devise_for :users
  #root 'application#hello'
  root 'static_pages#landingpg'
end
