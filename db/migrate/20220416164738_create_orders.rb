class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coupon, null: true, foreign_key: true
      t.references :credit_card, null: false, foreign_key: true
      t.references :delivery, null: false, foreign_key: true
      t.string :status, null: false
      t.datetime :completed_at, null: true
      t.timestamps
    end
  end
end