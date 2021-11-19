class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.belongs_to :user, null: false, foreign_key: true, unique: true
      t.integer :amount
      t.integer :total

      t.timestamps
    end
  end
end
