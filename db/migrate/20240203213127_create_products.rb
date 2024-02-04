class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.references :author, foreign_key: true
      t.references :translator, foreign_key: true
      t.references :publisher, foreign_key: true
      t.references :discount, foreign_key: true
      t.string :title
      t.text :summary
      t.integer :quantity
      t.string :weight
      t.string :size
      t.string :price
      t.integer :rate
      t.string :publish_year
      t.integer :pages_count
      t.integer :visit_count
      t.text :index_value
      t.string :isbn
      t.string :image_url
      t.string :thumbnail_image_url
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
