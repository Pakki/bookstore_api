class ChangeDataTypeForBooks < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :price, :integer
  end
end
