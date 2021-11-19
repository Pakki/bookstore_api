class BookSerializer
  include JSONAPI::Serializer
  #attributes :"title,", :"author,", :"genre,", :price
  attributes :title, :author, :genre, :price
end
