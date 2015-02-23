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

  root 'external#index'
  get 'dashboard' => 'dashboard', as: :dashboard

  #### User Admin ##############################################################
  get 'pending_approvals' => 'admin/users#pending_approvals', as: :pending_approvals
  post 'approve_user'     => 'admin/users#approve_user',      as: :approve_user
  post 'reject_user'      => 'admin/users#reject_user',       as: :reject_user
  get  'update_users'     => 'admin/users#update_users',      as: :update_users
  post 'update_status'    => 'admin/users#update_status',     as: :update_status
  resources :positions, controller: 'admin/positions', only: [ :create, :update, :destroy ]

  #### Quick Links #############################################################
  resources :links, except: [:show, :destroy, :edit, :update, :new] do
    post :deactivate, on: :member
  end

  #### Attendance ##############################################################
  get 'leaderboard'        => 'attendance/leaderboard#index',       as: :leaderboard
  get  'outstanding_fines' => 'attendance/fines#outstanding_fines', as: :outstanding_fines
  get  'update_fines'      => 'attendance/fines#update_fines',      as: :update_fines
  get  'pending_excuses'   => 'attendance/excuses#pending_excuses', as: :pending_excuses
  get  'excuses'           => 'attendance/excuses#index',           as: :excuses
  post 'process_excuse'    => 'attendance/excuses#process_excuse',  as: :process_excuse
  post 'submit_excuse'     => 'attendance/excuses#submit_excuse',   as: :submit_excuse

  resources :events, controller: 'attendance/events'
  resources :fines, controller: 'attendance/fines', only: [:index, :update]
  resources :attendances, controller: 'attendance/attendances', only: [:update]
  resources :event_types, controller: 'attendance/event_types', except: [:show]

  #### Org Chart ###############################################################
  resources :org_chart, controller: 'org_chart', only: [:index]
  get 'org_chart_admin' => 'org_chart#admin', as: 'org_chart_admin'
  post 'org_chart_create' => 'org_chart#create', as: 'org_chart_create'
  post 'org_chart_remove' => 'org_chart#remove', as: 'org_chart_remove'

end
