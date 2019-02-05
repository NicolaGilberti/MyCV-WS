Rails.application.routes.draw do
  root to: 'home#index'
  get '/home/jobs', to: 'home#jobs', as: 'jobs'
  resources :data_manager

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'users/omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'users/omniauth_callbacks#setup'
  end
end
