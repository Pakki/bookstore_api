class Item < ApplicationRecord
  before_save :calculate_subtotal
  after_save :calculate_cart
  belongs_to :cart
  belongs_to :book, inverse_of: :items

  private

  def calculate_subtotal
    self.subtotal = self.price * self.quantity
  end

  def calculate_cart
    self.cart.calculate_total
  end
end
