Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "welcome#index"

  namespace :my do
    root to: "welcome#index"

    devise_for :users, controllers: {
      sessions: "my/sessions",
      registrations: "my/registrations"
    }

    resources :posts
  end
end
