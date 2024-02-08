class CreateAppMeta < ActiveRecord::Migration[7.1]
  def change
    create_table :app_meta do |t|
      t.string :shop_name
      t.string :first_phone
      t.string :second_phone
      t.string :instagram
      t.string :telegram
      t.string :whatsapp
      t.string :facebook
      t.string :linkedin
      t.string :twitter
      t.string :youtube
      t.string :aparat
      t.string :email
      t.string :address
      t.string :latitude
      t.string :longitude
      t.text :terms
      t.text :about_us
      t.json :meta
      t.text :description
      t.datetime :created_at
      t.datetime :updated_at

    end
  end
end
