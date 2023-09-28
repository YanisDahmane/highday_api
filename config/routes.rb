Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope :api do
    scope :auth do
      post "/login", to: "authentication#login"
      post "/register", to: "authentication#register"

      get "/whoami", to: "authentication#whoami"
    end

  end
end
