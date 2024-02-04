class CreateProvinces < ActiveRecord::Migration[7.1]
  def change
    create_table :provinces do |t|
      t.string :name
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
