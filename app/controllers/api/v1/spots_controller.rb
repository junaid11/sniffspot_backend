require_relative './serializers/spot_serializer'

class Api::V1::SpotsController < Api::V1::ApiController
  before_action :set_spot, only: [:show, :update, :destroy]

  def index
    spots = Spot.all
    render json: spots, each_serializer: Api::V1::Serializers::SpotSerializer
  end

  def show
    render json: @spot, serializer: Api::V1::Serializers::SpotSerializer
  end

  def create
    spot = Spot.new(spot_params)
    if spot.save
      render json: spot, serializer: Api::V1::Serializers::SpotSerializer, status: :created
    else
      render json: { errors: spot.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @spot.update(spot_params)
      render json: @spot, serializer: Api::V1::Serializers::SpotSerializer
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

  def spot_params
    params.require(:spot).permit(:title, :description, :price ,:user_id, images: [:url])
  end
end