class CreateAppLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :app_logs do |t|
      t.integer :user_id
      t.string :log
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
