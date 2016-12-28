Rails.application.routes.draw do
  
  resources :cards

  resources :reports

  resources :invites

  resources :blogs do
    collection do
      get 'venues'
      get 'networking-tips'
      get 'dating-tips'
      get 'spefz-news'
    end
  end

  resources :hosts
  resources :subscriptions
  resources :payments
  resources :socials
  resources :signups
  resources :relationships, only: [:create, :destroy]

  resources :friendships,   only: [:create, :update, :destroy]

  resources :favourite_socials, only: [:create, :destroy]
  resources :attending_socials, only: [:create, :destroy]
  resources :favourite_events, only: [:create, :destroy]
  resources :attending_events, only: [:create, :destroy]

  devise_for :users
  resources :users do
    resources :comments, only: [:create, :destroy] 
    resources :socials
    resources :events
    resources :blogs
    member do
      get 'dashboard'
      get 'membership'
      get 'account'
      get 'settings'

      get 'analytics'
      get 'company'
      get 'stats-users'
      get 'stats-socials'
      get 'stats-events'
      get 'transactions'
      get 'stats-blogs'
      get 'inquiries'
      get 'network'
      get 'followings'
      get 'followers'
    end
  end

  resources :activities do
    collection do
      get 'networks'
      get 'followings'
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

  resources :contacts
  get 'contact-us',              to: 'contacts#new'

  #conversations
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  
  #static pages
  root  'static_pages#homepg'
  get   'about-us',                       to: 'static_pages#aboutpg'
  get   'error',                          to: 'static_pages#errorpg'
  get   'errorpermission',                to: 'static_pages#errorpermissionpg'
  get   'help',                           to: 'static_pages#helppg'
  get   'help/account-and-profile',       to: 'static_pages#accountpg'
  get   'help/cancellations-and-refunds', to: 'static_pages#cancellationsrefundpg'
  get   'help/faqs',                      to: 'static_pages#faqspg'
  get   'help/membership',                to: 'static_pages#membershippg'
  get   'help/partners',                  to: 'static_pages#partnerspg'
  get   'help/payment-queries',           to: 'static_pages#paymentqueriespg'
  get   'landing-page',                   to: 'static_pages#landingpg'
  get   'image-restriction-page',         to: 'static_pages#imagepg'
  get   'message-delivered',              to: 'static_pages#messagesentpg'
  get   'notes',                          to: 'static_pages#notepg'
  get   'terms',                          to: 'static_pages#termspg'
  get   'terms/cookie-policy',            to: 'static_pages#cookiepg'
  get   'terms/privacy',                  to: 'static_pages#privacypg'
  get   'tags/:tag',                      to: 'users#index', as: :tag
  get   'socialtags/:tag',                to: 'socials#index', as: :social_tag
  get   'eventtags/:tag',                 to: 'events#index', as: :event_tag

  #massages folder routes
  get "messages/inbox",                   to: "messages#inbox", as: :message_inbox
  get "messages/sent",                    to: "messages#sent",  as: :message_sent
  get "messages/trash",                   to: "messages#trash", as: :message_trash
end

