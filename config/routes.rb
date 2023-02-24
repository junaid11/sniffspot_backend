Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :spots do
        resources :reviews, only: %i[index show create update destroy]
        resources :images, only: [:create]
      end
    end
  end
end
