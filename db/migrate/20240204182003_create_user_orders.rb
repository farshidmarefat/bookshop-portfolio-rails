class CreateUserOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :user_orders do |t|
      t.references :user, foreign_key: true
      t.references :order_status_type, foreign_key: true
      t.string :total_price
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
