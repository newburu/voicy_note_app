class SessionsController < ApplicationController
  def create
    # Step 11で作成したメソッドを呼び出し、ユーザーを検索または作成
    user = User.find_or_create_from_auth(auth_hash)

    if user
      # ログイン成功
      session[:user_id] = user.id # セッションにユーザーIDを保存
      redirect_to root_path, notice: "ログインしました"
    else
      # (基本的には発生しないが) 万が一ユーザーが見つからなければ
      redirect_to root_path, alert: "ログインに失敗しました"
    end
  end

  def destroy
    # セッションからユーザーIDを削除（ログアウト）
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました"
  end

  def failure
    # 認証失敗時
    redirect_to root_path, alert: "認証に失敗しました"
  end

  private

  # OmniAuthから送られてくる認証情報を取得
  def auth_hash
    request.env["omniauth.auth"]
  end
end
