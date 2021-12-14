class CreateCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkouts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :delivery, null: true, foreign_key: true
      t.references :credit_card, null: true, foreign_key: true
      t.boolean :use_billing_address, null: false, default: false
      t.string :stage, null: false, default: Checkout::STAGES.values.first
      t.timestamps
    end
  end
end