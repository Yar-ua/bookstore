class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.references :book, null: false, foreign_key: true
      t.monetize :price
      t.integer :quantity, null: false, default: 1
      t.references :cart, polymorphic: true
      t.timestamps
    end
  end
end
