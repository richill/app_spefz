Rails.application.routes.draw do
  
  resources :businessads

  resources :photos

  resources :albums do
    member do
      get 'preview'
    end
  end

  resources :externalattendinglists

  resources :preferences

  resources :managements do
    collection do
      get 'details'
    end
  end

  resource :bankcard

  resources :venues

  resources :invite_requests

  post '/rate' => 'rater#create', :as => 'rate'
  resources :cards do
    post :mark_as_viewed
  end

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
  resources :payments do
    collection do
      get 'externalplatform'
    end
  end
  resources :signups
  resources :relationships, only: [:create, :destroy]

  resources :friendships,   only: [:create, :update, :destroy]

  resources :favourite_socials, only: [:create, :destroy]
  resources :attending_socials, only: [:create, :destroy]
  resources :favourite_events, only: [:create, :destroy]
  resources :attending_events, only: [:create, :destroy]

  devise_scope :user do
    root  'devise/sessions#new'
    get 'signin', to: 'devise/sessions#new' #signin_path
    get 'signup', to: 'devise/registrations#new', as: "new_user_registration" # custom path to sign_up/registration
    #get 'signin', to: 'devise/sessions#new', as: "user_session" #signin_path
  end

  devise_for :users, controllers: {registrations: 'users/registrations'}, defaults: { format: 'html' }
  resources :users do
    resources :comments, only: [:create, :destroy] 
    resources :socials
    resources :events
    resources :blogs
    resources :preferences
    resources :businessads
    member do
      get 'dashboard'
      get 'membership'
      get 'account'
      get 'settings'

      get 'analytics'
      get 'company'
      get 'stats-users'
      get 'groups'
      get 'stats-socials'
      get 'stats-events'
      get 'transactions'
      get 'stats-blogs'
      get 'inquiries'
      get 'reports'
      get 'network'
      get 'followings'
      get 'followers'
      get 'matches'
      get 'cancellation'
      get 'documentation-links'
      get 'stats-albums'
      get 'stats-photos'

      get 'attending-socials'
      get 'attending-events'
      get 'saved-socials'
      get 'saved-events'
      get 'live-socials'
      get 'expired-socials'
      get 'connect-matches'
    end
  end

  resources :activities do
    post :mark_as_viewed
    collection do
      get 'networks'
      get 'followings'
    end
  end

  resources :events do
    resources :cards
    resources :hosts
    resources :externalattendinglists
    member do
      get 'attendants'
      get 'preview'
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

  mount Ckeditor::Engine => '/ckeditor'
  
  #static pages
  # root  'static_pages#homepg'
  get   'about-us',                       to: 'static_pages#aboutpg'
  get   'business-proposal',              to: 'static_pages#businessproposalpg'
  get   'error',                          to: 'static_pages#errorpg'
  get   'errorpermission',                to: 'static_pages#errorpermissionpg'
  get   'help',                           to: 'static_pages#helppg'
  get   'help/account-and-profile',       to: 'static_pages#accountpg'
  get   'help/cancellations-and-refunds', to: 'static_pages#cancellationsrefundpg'
  get   'help/faqs',                      to: 'static_pages#faqspg'
  get   'help/membership',                to: 'static_pages#membershippg'
  get   'help/partners',                  to: 'static_pages#partnerspg'
  get   'help/payment-queries',           to: 'static_pages#paymentqueriespg'
  get   'image-restriction-page',         to: 'static_pages#imagepg'
  get   'investment',                     to: 'static_pages#investmentpg'
  get   'information-page',               to: 'static_pages#informationpg'
  get   'landing-page',                   to: 'static_pages#landingpg'
  get   'message-delivered',              to: 'static_pages#messagesentpg'
  get   'notes',                          to: 'static_pages#notepg'
  get   'presentation',                   to: 'static_pages#presentationpg'
  get   'sponsorship',                    to: 'static_pages#sponsorshippg'
  get   'terms',                          to: 'static_pages#termspg'
  get   'terms/cookie-policy',            to: 'static_pages#cookiepg'
  get   'terms/privacy',                  to: 'static_pages#privacypg'
  get   'terms/gdpr',                     to: 'static_pages#gdprpg'
  get   'tags/:tag',                      to: 'users#index', as: :tag
  get   'socialtags/:tag',                to: 'socials#index', as: :social_tag
  get   'eventtags/:tag',                 to: 'events#index', as: :event_tag

  #massages folder routes
  get "messages/inbox",                   to: "messages#inbox", as: :message_inbox
  get "messages/sent",                    to: "messages#sent",  as: :message_sent
  get "messages/trash",                   to: "messages#trash", as: :message_trash
end

