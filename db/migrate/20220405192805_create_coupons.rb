class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.integer :amount, null: false
      t.timestamps
      
      t.index :code, unique: true
    end
  end
end
