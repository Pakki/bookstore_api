require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "should have a positive price" do
    book = books(:one)
    book.price = -1
    assert_not book.valid?
  end
end
