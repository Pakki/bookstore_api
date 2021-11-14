Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "tokens/create"
    end
  end
  # API definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # resourses list
      resources :users, only: %i[show create update destroy]
      resources :tokens, only: [:create]
      resources :books, only: %i[index show create update destroy]
    end
  end
end
