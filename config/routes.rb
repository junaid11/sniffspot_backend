Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :spots do
        resources :reviews, only: [:index, :show, :create, :update, :destroy]
        resources :images, only: [:index, :create]
      end
    end
  end
end
