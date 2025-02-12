class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :full_name
      t.string :avatar_url
      t.string :avatar
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
