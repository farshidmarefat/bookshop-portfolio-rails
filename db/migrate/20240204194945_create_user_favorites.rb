class CreateUserFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :user_favorites do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
