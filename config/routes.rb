Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :clients, only: %i[index show] do
    resources :body_stats, only: %i[create]
    resources :workout_plans, only: %i[create]
  end

  resources :workout_plan, only: [] do
    resources :workout_sessions, only: %i[create]
  end

  resources :workout_sessions, only: %i[show] do
    resources :session_exercises, only: %i[create]
    resources :comments, only: %i[create]
  end

  resources :workout_sessions do
    resources :session_exercises do
      member do
        patch :mark_done
      end
    end
  end
end
