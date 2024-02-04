class CreateBlogComments < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_comments do |t|
      t.references :user, foreign_key: true
      t.references :blog_post, foreign_key: true
      t.string :body
      t.boolean :verified, default: false
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
