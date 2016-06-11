Rails.application.routes.draw do
  devise_for :users
  #root 'application#hello'
  root 'static_pages#landingpg'
end
