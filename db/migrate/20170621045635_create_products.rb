class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.string :picture
      t.string :slug

      t.timestamps
    end
    add_index :products, :slug, unique: true
  end
end
