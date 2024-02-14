class CreateSelectedContexts < ActiveRecord::Migration[7.1]
  def change
    create_table :selected_contexts do |t|
      t.references :product, foreign_key: true
      t.string :full_name
      t.string :body
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
