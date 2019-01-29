Rails.application.routes.draw do
  root to: "home#index"

  get '/home/jobs', to: 'home#jobs', as: 'jobs'
end
