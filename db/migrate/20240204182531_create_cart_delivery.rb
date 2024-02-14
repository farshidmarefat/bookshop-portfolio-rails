class CreateCartDelivery < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_deliveries do |t|
      t.references :user_address, foreign_key: true
      t.boolean :in_person
      t.datetime :delivery_time
      t.string :shipping_cost
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
