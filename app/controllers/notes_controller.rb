class NotesController < ApplicationController
  # このコントローラの全てのアクションの前に、ログインしているか確認する
  before_action :require_login

  # メモ一覧（トップページとは別に、自分のメモだけを見るページ）
  def index
    # ログイン中のユーザーのメモだけを、作成日が新しい順に取得
    @notes = current_user.notes.order(created_at: :desc)
  end

  # メモの新規作成ページ (URL貼り付けフォーム)
  def new
    @note = Note.new
  end

  # メモの作成処理
  def create
    @note = current_user.notes.build(note_params)

    # ▼▼ ここでURL解析とメタデータ取得を行う ▼▼
    begin
      # (注: ここは後で「URLからメタデータを取得する処理」を追加する場所)
      # 仮でタイトルなどを手動で設定（後で自動化）
      if @note.voicy_url.present?
        @note.title ||= "（仮）Voicyタイトル"
        @note.personality_name ||= "（仮）パーソナリティ名"
        @note.channel_name ||= "（仮）チャンネル名"
      end

      if @note.save
        redirect_to notes_path, notice: "メモを作成しました"
      else
        # 保存に失敗したら、newテンプレートを再表示
        render :new, status: :unprocessable_entity
      end
    rescue => e
      # URL解析失敗などのエラーハンドリング
      flash.now[:alert] = "URLの解析に失敗しました: #{e.message}"
      render :new, status: :unprocessable_entity
    end
  end

  # (メモの編集、削除機能は後で追加)

  private

  # Strong Parameters (フォームから受け取る値を許可)
  def note_params
    params.require(:note).permit(:voicy_url, :body, :start_time)
  end
end
