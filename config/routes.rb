Rails.application.routes.draw do
  # API definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # resourses list
      resources :users, only: %i[show create update destroy]
    end
  end
end
