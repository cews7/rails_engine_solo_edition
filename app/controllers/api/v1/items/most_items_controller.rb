class Api::V1::Items::MostItemsController < ApplicationController
  def index
    render json: Item.most_items_sold(params[:quantity])
  end
end
