require "test_helper"

class Api::V1::BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @user = users(:one)
    @admin = users(:admin)
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

  test "should create book" do
    assert_difference("Book.count") do
      post api_v1_books_url,
           params: { book: { title: @book.title, author: @book.author,
                            genre: @book.genre, price: @book.price } },
           headers: { Authorization: JsonWebToken.encode(user_id: @admin.id) }, as: :json
    end
    assert_response :created
  end

  test "should forbid create book" do
    assert_no_difference("Book.count") do
      post api_v1_books_url,
           params: { book: { title: @book.title,
                            author: @book.author, genre: @book.genre,
                            price: @book.price } },
           headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    end
    assert_response :forbidden
  end

  test "should update book" do
    patch api_v1_book_url(@book),
          params: { book: { title: @book.title } },
          headers: { Authorization: JsonWebToken.encode(user_id: @admin.id) },
          as: :json
    assert_response :success
  end
  test "should forbid update book" do
    patch api_v1_book_url(@book),
          params: { book: { title: @book.title } },
          headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
          as: :json
    assert_response :forbidden
  end

  test "should destroy book" do
    assert_difference("Book.count", -1) do
      delete api_v1_book_url(@book),
             headers: { Authorization: JsonWebToken.encode(user_id: @admin.id) }, as: :json
    end
    assert_response :no_content
  end

  test "should forbid destroy book" do
    assert_no_difference("Book.count") do
      delete api_v1_book_url(@book),
             headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    end
    assert_response :forbidden
  end
end
