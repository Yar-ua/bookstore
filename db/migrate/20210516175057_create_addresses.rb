class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :type, null: false
      t.string :addressable_type
      t.bigint :addressable_id
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.integer :zip, null: false
      t.string :country, null: false
      t.string :phone, null: false
      # t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    
    add_index :addresses, %i[type addressable_type addressable_id]
  end
end
