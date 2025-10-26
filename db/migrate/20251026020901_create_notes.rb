class CreateNotes < ActiveRecord::Migration[8.1]
  def change
    create_table :notes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :voicy_url
      t.string :title
      t.string :personality_name
      t.string :channel_name
      t.text :body
      t.string :start_time

      t.timestamps
    end
  end
end
