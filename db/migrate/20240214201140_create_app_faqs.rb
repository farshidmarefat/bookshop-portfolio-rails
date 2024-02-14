class CreateAppFaqs < ActiveRecord::Migration[7.1]
  def change
    create_table :app_faqs do |t|
      t.string :question
      t.string :answer
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
