class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :mobile_number
      t.string :email
      t.boolean :is_customer
      t.boolean :is_super_admin
      t.boolean :is_admin
      t.boolean :is_blog_author
      t.string :avatar_url
      t.string :access_token
      t.string :verify_code
      t.boolean :verified
      t.string :nick_name
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
