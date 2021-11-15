class Book < ApplicationRecord
  validates :title, :author, :genre, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  has_many :items, dependent: :destroy
end
