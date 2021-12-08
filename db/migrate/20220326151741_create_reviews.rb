class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :score, null: false
      t.string :title, null: false
      t.text :message, null: false
      t.integer :status, null: false, default: 0
      t.references :book, null: false, foreign_key: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
