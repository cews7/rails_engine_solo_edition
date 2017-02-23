class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).favorite_customer, serializer: CustomerSerializer
  end
end
