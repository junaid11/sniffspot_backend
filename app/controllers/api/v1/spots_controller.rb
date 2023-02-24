require './spec/support/api/v1/api_schema.rb'
require_relative './serializers/spot_serializer'

class Api::V1::SpotsController < Api::V1::ApiController
  before_action :set_spot, only: [:show, :update, :destroy]
  before_action :authorize_user!, only: [:update, :destroy]

  def index
    spots = Spot.all
    render json: spots, each_serializer: Api::V1::SpotSerializer
  end

  def show
    render json: @spot, serializer: Api::V1::SpotSerializer
  end

  def create
    spot = Spot.new(spot_params)

    if spot.save
      render json: spot, serializer: Api::V1::SpotSerializer, schema: api_schema.show_response_schema, status: :created
    else
      render json: { errors: spot.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @spot.update(spot_params)
      render json: @spot, serializer: Api::V1::SpotSerializer, schema: api_schema.show_response_schema
    else
      render json: { errors: @spot.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @spot.destroy
    head :no_content
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def authorize_user!
    head :unauthorized unless current_user && current_user == @spot.user
  end

  def spot_params
    params.require(:spot).permit(:title, :description, :price, images: [:url])
  end

  def api_schema
    case request.headers['Accept']
    when 'application/vnd.spots.v1+json'
      Api::V1::ApiSchema
    else
      Api::V1::ApiSchema
    end
  end
end