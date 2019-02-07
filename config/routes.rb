Rails.application.routes.draw do
  root to: 'home#collect_data'

  post '/home/jobs', to: 'home#jobs', as: 'jobs'
  post '/home/collect_data', to: 'home#collect_data', as: 'collect'
  post '/home/update_data', to: 'home#update_data', as: 'update'
  get '/home/generate_cv/:position', to: 'home#generate_cv', as: 'generate'

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  devise_scope :user do
    get '/users/auth/:provider/upgrade' => 'users/omniauth_callbacks#upgrade', as: :user_omniauth_upgrade
    get '/users/auth/:provider/setup', :to => 'users/omniauth_callbacks#setup'
  end
end
