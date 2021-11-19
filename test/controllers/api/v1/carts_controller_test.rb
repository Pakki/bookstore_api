require "test_helper"

class Api::V1::CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
    @item_params = { item: { book_id: books(:two).id, price: books(:two).price, quantity: 1 } }
    @item_one = items(:one)
    @item_change_quantity_params = { item: { id: @item_one.id, quantity: 4 } }
  end

  test "should forbid carts for unlogged" do
    get api_v1_carts_url, as: :json
    assert_response :forbidden
  end

  test "should show cart" do
    get api_v1_carts_url, headers: { Authorization: JsonWebToken.encode(user_id: @cart.user_id) }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal @cart.total, json_response.dig(:data, :attributes, :total)
  end

  test "should forbid add item to cart for unlogged" do
    assert_no_difference("Item.count") do
      post api_v1_carts_url, params: @item_params, as: :json
    end
    assert_response :forbidden
  end

  test "should add item to cart" do
    assert_difference("Item.count", 1) do
      post api_v1_carts_url,
           params: @item_params,
           headers: { Authorization: JsonWebToken.encode(user_id: @cart.user_id) }, as: :json
    end
    assert_response :created
  end

  test "should forbid change item quantity for unlogged" do
    patch api_v1_cart_url(@cart), params: @item_change_quantity_params, as: :json
    assert_response :forbidden
  end

  test "should change item quantity" do
    patch api_v1_cart_url(@cart),
          params: @item_change_quantity_params,
          headers: { Authorization: JsonWebToken.encode(user_id: @cart.user_id) }, as: :json
    json_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal @item_change_quantity_params[:item][:quantity],
                 json_response[:included][0][:attributes][:quantity]
    assert_response :accepted
  end
end
