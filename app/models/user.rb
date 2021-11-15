class User < ApplicationRecord
  after_create :create_cart
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true

  has_secure_password

  has_one :cart, dependent: :destroy

  private

  def create_cart
    cart = Cart.new(user_id: self.id)
    cart.amount = 0
    cart.total = 0
    cart.save
  end
end
