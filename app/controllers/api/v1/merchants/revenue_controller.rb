class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.revenue, serializer: RevenueSerializer
  end
end
