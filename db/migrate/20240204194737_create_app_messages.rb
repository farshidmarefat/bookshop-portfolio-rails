class CreateAppMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :app_messages do |t|
      t.string :message_text_en
      t.string :message_text_fa
      t.integer :message_type
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
