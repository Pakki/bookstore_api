class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.belongs_to :cart, null: false, foreign_key: true
      t.belongs_to :book, null: false, foreign_key: true
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.integer :subtotal, null: false

      t.timestamps
    end
  end
end
