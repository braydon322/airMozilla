Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :webinars
    end
  end

  root to: 'api/v1/webinars#index'
end
