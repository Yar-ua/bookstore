class CreateCreditCards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :number, null: false
      t.string :cvv, null: false
      t.integer :expiration_month, null: false
      t.integer :expiration_year, null: false
      t.string :cardholder_name, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end