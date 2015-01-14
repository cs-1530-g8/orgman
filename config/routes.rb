Rails.application.routes.draw do

  # Add devise routes for users
  # devise_for :users
  devise_for :users, skip: [:sessions, :registrations, :password, :confirmation,
                            :unlock]

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
  post 'approve_user'     => 'admin/users#approve_user',      as: :approve_user
  post 'reject_user'      => 'admin/users#reject_user',       as: :reject_user

  get 'index' => 'external#index', as: :external_index

  get 'leaderboard' => 'attendance/leaderboard#index', as: :leaderboard

  get 'dashboard' => 'dashboard', as: :dashboard

  get  'update_users'     => 'update_users#index',            as: :update_users
  post 'update_status'    => 'update_users#update_status',    as: :update_status
  post 'update_positions' => 'update_users#update_positions', as: :update_positions
  post 'update_event_type_admin' => 'update_users#update_event_type_admin',
       as: :update_event_type_admin

  resources :event_types, controller: 'attendance/event_types' do
    get :delete, on: :member
  end

  resources :links, except: [:show, :destroy, :edit, :update, :new] do
    post :deactivate, on: :member
  end

  get  'outstanding_fines' => 'attendance/fines#outstanding_fines', as: :outstanding_fines
  get  'pending_excuses'   => 'attendance/excuses#pending_excuses', as: :pending_excuses
  post 'process_excuse'    => 'attendance/excuses#process_excuse',  as: :process_excuse
  resources :events, controller: 'attendance/events'
  resources :fines, controller: 'attendance/fines', only: [:index, :update]
  resources :attendances, only: [:update], controller: 'attendance/attendances'
  resources :excuses, controller: 'attendance/excuses', only: [ :index, :create,
                                                                :destroy ]

  root 'external#index'
end
