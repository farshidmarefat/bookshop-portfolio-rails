class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.string :title
      t.integer :percent
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :expired, default: false
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
