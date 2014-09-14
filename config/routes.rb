Rails.application.routes.draw do
  get 'external/index'

  devise_for :users

  root 'external#index'
end
