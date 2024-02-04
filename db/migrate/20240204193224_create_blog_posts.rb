class CreateBlogPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_posts do |t|
      t.references :blog_category, foreign_key: true
      t.string :title
      t.text :body
      t.string :slug
      t.string :image_url
      t.string :thumbnail_image_url
      t.boolean :published, default: false
      t.integer :visit_count, default: 0
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
