Rails.application.routes.draw do
  get "sessions/create"
  get "sessions/destroy"
  get "sessions/failure"
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # トップページのルート (仮)
  root "home#index"

  # OmniAuthのコールバック（認証後に戻ってくる場所）
  # /auth/google_oauth2/callback というURLで sessions#create が呼ばれる
  get "/auth/:provider/callback", to: "sessions#create"

  # 認証失敗時のルート
  get "/auth/failure", to: "sessions#failure"

  # ログアウト用のルート
  delete "/logout", to: "sessions#destroy"
end
