# config/initializers/omniauth.rb

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    # どのような情報（scope）をGoogleから受け取るか指定
    scope: "email,profile",
    # ユーザーが毎回「許可」ボタンを押さなくても良いようにする
    prompt: "select_account"
  }
end

# 認証が失敗したときの処理
OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
