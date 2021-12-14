class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.string :method, null: false
      t.string :days
      t.monetize :price
      t.timestamps
    end
  end
end