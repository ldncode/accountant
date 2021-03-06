Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :destroy] do
        resources :accounts do
          resources :expenses
        end
      end
    end
  end
end
