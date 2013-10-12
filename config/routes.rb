HungerGame::Application.routes.draw do

  get "password_resets/new"
  get "email_blasts/new"
  #get "users/new"
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :user, :skip => [:sessions,:registrations]
  devise_scope :user do
    get 'signin' => 'user/sessions#new', :as => :new_user_session
    post 'signin' => 'user/sessions#create', :as => :user_session
    delete 'signout' => 'user/sessions#destroy', :as => :destroy_user_session
    get "/register" => "user/registrations#new"
    post "/register" =>"user/registrations#create"
  end
  match 'reset_password' => 'users#reset_password', :as => :reset_password, :via => :put


   root 'home#dashboard'
   get '/login' => 'home#login'

  resources :users do
    collection do
      get 'import_users'
      post 'post_import_from_csv'  
      get 'scoreboard'

    end
  end

   resources :challenges
   resources :mini_challenges
   resources :password_resets
   resources :email_templates do
     collection do
       post 'send_registration_email_template'
       post 'send_new_challenge_template'
       post 'send_player_denied_email_template'
       post 'send_player_winner_email_template'
     end 
   end

   resources :video_pages, :only => [:new, :create]
   resources :email_blasts, :only => [:new, :create] do
    collection do
      post 'send_email_blast'
    end
   end
   resources :player_challenges
   get  '/reset/password'                  =>  'users#change_password',                     :as   =>  :change_password
   #match '/reset_password(/:token)'          =>  'users#reset_password',                      :as   =>  :post_reset_password


   ## FOR API

  namespace :api, :defaults => {:format => 'json'} do
    scope :module => :v1 do

      post  'login'  => 'sessions#create',  as: :login
      match 'logout' => 'sessions#destroy', as: :logout, via: [:get, :delete, :post]

      resources :player_challenges, only: [:create] do
        collection do
          post 'list_of_player_for_challenge'
        end
      end

      resources :mini_challenges, only: [:index, :create]
      
      resources :challenges, only: [:index] do
        collection do
          post 'challenge_like'
        end
      end
      
      resources :users, only: [:create] do
        collection do
          post 'forget_password'
          post 'get_profile'
          post 'edit_profile'
          post 'endorsement'
          post 'search'
          get  'md_user_type_list'
          get  'accept_reject_of_player'
          post 'accept_or_reject_player'
          get   'scoreboard'
          post 'support_to_player'
          get 'player_user_list'
        end
      end

      resources :judge_points, only: [:create]

      resources :social_media_points, only: [:index] do
        collection do
          post 'social_media_like'
        end
      end

      resources :skills, only: [:index]
      resources :activity_feeds, only: [:create, :index] do
        collection do
          post 'like_n_dislike_activity_feed'
          post 'comment_on_activity_feed'
        end
      end
    end
  end
end
