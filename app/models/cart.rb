class Cart < ApplicationRecord
  belongs_to :user
  validates :user, uniqueness: true, presence: true
  has_many :items, dependent: :destroy
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true

  def calculate_total
    result = Item.where(cart_id: self.id).select("SUM(quantity) as quantity, SUM(subtotal) as subtotal").first
    self.amount = result[:quantity] || 0
    self.total = result[:subtotal] || 0
    self.save
  end
end
