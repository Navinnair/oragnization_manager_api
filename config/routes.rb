Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#authenticate'

  namespace :api do
    scope module: :v1 do
      resources :companies, only: %i[index show create destroy] do
        resources :employees, only: %i[show create destroy]
      end
    end
  end
end
