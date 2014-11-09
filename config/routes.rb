Rails.application.routes.draw do
  get 'index' => 'external#index', as: :external_index
  get 'pending_approvals' => 'admin/users#pending_approvals', as: :pending_approvals
  get 'approve_user' => 'admin/users#approve_user', as: :approve_user
  get 'quick_links' => 'quick_links#index', as: :quick_links
  post 'create_quick_link' => 'quick_links#create', as: :create_quick_link
  get 'deactivate_quick_link' => 'quick_links#deactivate', as: :deactivate_quick_link

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

  root 'external#index'
end
