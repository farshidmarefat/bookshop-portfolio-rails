class CreateUserOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :user_order_items do |t|
      t.references :user_order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
