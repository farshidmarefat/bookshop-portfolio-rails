class CreateAppAdvantages < ActiveRecord::Migration[7.1]
  def change
    create_table :app_advantages do |t|
      t.string :title
      t.string :summary
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
