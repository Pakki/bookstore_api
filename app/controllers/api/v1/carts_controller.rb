class Api::V1::CartsController < ApplicationController
  before_action :check_login, only: %i[index create update destroy]

  def index
    render json: CartSerializer.new(current_user.cart,
                                    include: ["items"]).serializable_hash.to_json
  end

  def create
    item = find_or_create_item
    if item.save
      render json: CartSerializer.new(current_user.cart,
                                      include: ["items"]).serializable_hash.to_json, status: :created
    else
      render json: { errors: cart.errors }, status: :unprocessable_entity
    end
  end

  def find_or_create_item
    item = current_user.cart.items.find_by(book_id: add_item_params[:book_id])
    if item
      item.price = add_item_params[:price]
      item.quantity += add_item_params[:quantity]
    else
      item = current_user.cart.items.new(add_item_params)
    end
  end

  def update
    item = current_user.cart.items.find(change_quantity_params[:id])
    item.quantity = change_quantity_params[:quantity]
    if item.save
      render json: CartSerializer.new(current_user.cart,
                                      include: ["items"]).serializable_hash.to_json, status: :accepted
    else
      render json: { errors: cart.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if params[:item]
      Item.destroy(params[:id])
    end

    if params[:items]
      params[:ids].each do |item_id|
        Item.destroy(item_id)
      end
    end

    if params[:cart]
      current_user.cart.items.destroy
    end
    render json: CartSerializer.new(current_user.cart,
                                    include: ["items"]).serializable_hash.to_json, status: :accepted
  end

  private

  def destroy_item
    params.require(:item).permit(:id)
  end

  def change_quantity_params
    params.require(:item).permit(:id, :quantity)
  end

  def add_item_params
    params.require(:item).permit(:book_id, :price, :quantity)
  end
end
