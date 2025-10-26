# app/models/user.rb

class User < ApplicationRecord
  # 関連付け
  has_many :notes

  # OmniAuthの認証情報（auth）を受け取って、ユーザーを検索または新規作成する
  def self.find_or_create_from_auth(auth)
    # authハッシュからproviderとuidを取得
    provider = auth.provider
    uid = auth.uid

    # providerとuidでユーザーを検索
    user = self.find_or_create_by(provider: provider, uid: uid) do |new_user|
      # ユーザーが見つからなかった場合（新規作成時）
      # Googleから取得した情報を設定する
      new_user.email = auth.info.email
      new_user.name = auth.info.name
    end

    user # ユーザーを返す
  end
end
