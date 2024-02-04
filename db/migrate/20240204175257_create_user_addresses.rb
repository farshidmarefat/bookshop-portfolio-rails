class CreateUserAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :user_addresses do |t|
      t.references :user, foreign_key: true
      t.references :province, foreign_key: true
      t.references :city, foreign_key: true
      t.string :title
      t.string :address
      t.string :latitude
      t.string :longitude
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
