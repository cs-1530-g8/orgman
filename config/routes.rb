Rails.application.routes.draw do
  get 'external/index'

  root 'external#index'
end
