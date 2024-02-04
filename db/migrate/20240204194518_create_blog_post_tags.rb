class CreateBlogPostTags < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_post_tags do |t|
      t.references :blog_post, foreign_key: true
      t.references :blog_tag, foreign_key: true
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
