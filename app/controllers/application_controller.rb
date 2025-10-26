class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # session[:user_id] があれば、現在のユーザー（@current_user）を取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ビュー（HTML）側でも current_user メソッドを使えるようにする
  helper_method :current_user

  # ログインしているか確認するメソッド
  def logged_in?
    current_user.present?
  end
  helper_method :logged_in?
end
