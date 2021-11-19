class ItemSerializer
  include JSONAPI::Serializer
  attributes :book, :price, :quantity, :subtotal
  belongs_to :cart
  belongs_to :book
end
