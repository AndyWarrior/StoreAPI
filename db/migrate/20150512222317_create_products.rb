class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.string :image_url
      t.integer :available

      t.timestamps null: false
    end
  end
end
