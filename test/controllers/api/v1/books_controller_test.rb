require "test_helper"

class Api::V1::BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  test "should show books" do
    get api_v1_books_url(), as: :json
    assert_response :success
  end

  test "should show book" do
    get api_v1_book_url(@book), as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body)
    assert_equal @book.title, json_response["title"]
  end
end
