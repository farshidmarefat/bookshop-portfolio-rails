class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :mobile_number
      t.string :email, null: false, default: ""
      t.boolean :is_customer
      t.boolean :is_super_admin
      t.boolean :is_admin
      t.boolean :is_blog_author
      t.string :avatar_url
      t.string :access_token
      t.string :verify_code
      t.boolean :verified, default: false
      t.string :nick_name
      t.json :meta
      t.text :description

      t.string :encrypted_password, null: false, default: ""
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.string :jti, null: false

      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :jti, unique: true
  end
end
