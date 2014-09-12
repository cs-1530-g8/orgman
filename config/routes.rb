Rails.application.routes.draw do
  devise_for :users
  get 'external/index'

  root 'external#index'
end
