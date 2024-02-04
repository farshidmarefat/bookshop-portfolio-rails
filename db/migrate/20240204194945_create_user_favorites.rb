class CreateUserFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :user_favorites do |t|
      t.integer :user_id
      t.integer :product_id
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
