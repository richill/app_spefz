Rails.application.routes.draw do
  
  resources :activities do
    collection do
      get 'networks'
    end
  end
  resources :subscriptions
  resources :payments
  resources :socials
  resources :signups
  resources :relationships, only: [:create, :destroy]
  resources :friendships,   only: [:create, :destroy]
  resources :favourite_socials, only: [:create, :destroy]
  resources :attending_socials, only: [:create, :destroy]

  resources :favourite_events, only: [:create, :destroy]
  resources :attending_events, only: [:create, :destroy]

  devise_for :users
  resources :users do
    resources :comments, only: [:create, :destroy] 
    resources :socials
    resources :events
    member do
      get 'dashboard'
      get 'membership'
      get 'account'
      get 'settings'
    end
  end

  resources :events do
    member do
      get 'attendants'
    end
  end

  resources :socials do
    resources :comments, only: [:create, :destroy] 
  end

  #conversations
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  

  get     'terms/acceptable-policy',  to: 'static_pages#acceptablepg'


  root  'static_pages#homepg'
  get   'about-us',                 to: 'static_pages#aboutpg'
  get   'account-and-profile',      to: 'static_pages#accountpg'
  get   'error',                    to: 'static_pages#errorpg'
  get   'errorpermission',          to: 'static_pages#errorpermissionpg'
  get   'help',                     to: 'static_pages#helppg'
  get   'landing-page',             to: 'static_pages#landingpg'
  get   'image-restriction-page',   to: 'static_pages#imagepg'
  get   'notes',                    to: 'static_pages#notepg'
  get   'terms/cookie-policy',      to: 'static_pages#cookiepg'
  get   'terms/privacy',            to: 'static_pages#privacypg'
  get   'terms',                    to: 'static_pages#termspg'

  get   'tags/:tag',                to: 'users#index', as: :tag
  get   'socialtags/:tag',          to: 'socials#index', as: :social_tag
  get   'eventtags/:tag',           to: 'events#index', as: :event_tag

  #massages folder routes
  get "messages/inbox",              to: "messages#inbox", as: :message_inbox
  get "messages/sent",               to: "messages#sent",  as: :message_sent
  get "messages/trash",              to: "messages#trash", as: :message_trash
end

