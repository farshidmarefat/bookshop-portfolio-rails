class CreateUserPermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :user_permissions do |t|
      t.references :user, foreign_key: true
      t.references :permission, foreign_key: true
      t.boolean :can_create
      t.boolean :can_read
      t.boolean :can_update
      t.boolean :can_delete
      t.boolean :can_visit
      t.json :meta
      t.text :description
      t.datetime :created_at, precision: 6
      t.datetime :updated_at, precision: 6
    end
  end
end
