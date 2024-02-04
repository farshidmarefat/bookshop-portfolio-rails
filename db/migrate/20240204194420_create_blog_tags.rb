class CreateBlogTags < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_tags do |t|
      t.string :title
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
