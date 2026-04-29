Rails.application.routes.draw do
  devise_for :users,
    path: "",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    },
    defaults: { format: :json }

  # Generates all standard REST API routes for jog entries
  resources :jog_entries do
    collection do
      get :report
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
