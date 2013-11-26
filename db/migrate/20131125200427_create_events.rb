class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :occurring_on
      t.string :location
      t.string :image_url
      t.integer :slots
      t.boolean :published
      t.boolean :public
      t.text :custom_fields_json

      t.timestamps
    end
  end
end
