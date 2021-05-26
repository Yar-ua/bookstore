class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :year, default: 1980
      t.integer :quantity, default: 0
      t.decimal :price, precision: 5, scale: 2
      t.decimal :height, precision: 4, scale: 2
      t.decimal :width, precision: 4, scale: 2
      t.decimal :depth, precision: 4, scale: 2
      t.integer :material

      t.timestamps
      
      t.references :category, null: false, foreign_key: true
    end
  end
end
