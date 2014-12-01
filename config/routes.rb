Rails.application.routes.draw do

  # Add devise routes for users
  # devise_for :users
  devise_for :users, skip: [:sessions, :registrations, :password, :confirmation, :unlock]

  # Rename devise routes to look nicer
  devise_scope :user do
    get    'login'    => 'devise/sessions#new',         as: :new_user_session
    post   'login'    => 'devise/sessions#create',      as: :user_session
    delete 'signout'  => 'devise/sessions#destroy',     as: :destroy_user_session

    get    'signup'   => 'registrations#new',           as: :new_user_registration
    post   'signup'   => 'registrations#create',        as: :user_registration
    put    'signup'   => 'registrations#update',        as: :update_user_registration
    get    'account'  => 'registrations#edit',          as: :edit_user_registration

    post   'password' => 'devise/passwords#create',     as: :user_password
    get    'password' => 'devise/passwords#new',        as: :new_user_password
    get    'password' => 'devise/passwords#edit',       as: :edit_user_password

    post   'confirm'  => 'devise/confirmations#create', as: :user_confirmation
    get    'confirm'  => 'devise/confirmations#new',    as: :new_user_confirmation

    post   'unlock'   => 'devise/unlocks#create',       as: :user_unlock
    get    'unlock'   => 'devise/unlocks#new',          as: :new_user_unlock
  end

  get 'pending_approvals' => 'admin/users#pending_approvals', as: :pending_approvals
  get 'approve_user'      => 'admin/users#approve_user',      as: :approve_user

  get 'index' => 'external#index', as: :external_index

  get 'leaderboard' => 'attendance/leaderboard#index', as: :leaderboard

  resources :event_types, controller: 'attendance/event_types' do
    get :delete, on: :member
  end

  resources :links, except: [:show, :destroy, :edit, :update, :new] do
    post :deactivate, on: :member
  end

  resources :events, controller: 'attendance/events'

  resources :attendances, only: [:update], controller: 'attendance/attendances'

  root 'external#index'
end
