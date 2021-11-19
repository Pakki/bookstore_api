class CartSerializer
  include JSONAPI::Serializer
  attributes :amount, :total
  belongs_to :user
  has_many :items
end
