class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :update, :destroy]
  before_action :authorize_user!, only: [:update, :destroy]
  before_action :set_cache_control_headers, only: [:index, :show]
  
  def index
    @spots = Rails.cache.fetch('spots_index', expires_in: 5.minutes) do
      Spot.all.page(params[:page]).per(params[:per_page] || 20)
      end
    render json: @spots
  end

  def create
    @spot = current_user.spots.new(spot_params)
    if @spot.save
      Rails.cache.delete('spots_index')
      render json: @spot, status: :created
    else
      render json: @spot.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @spot
  end

  def update
    if @spot.update(spot_params)
      Rails.cache.delete('spots_index')
      render json: @spot
    else
      render json: @spot.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @spot.destroy
    Rails.cache.delete('spots_index')
    head :no_content
  end

  private

  def set_spot
    @spot = Spot.includes(:reviews, :images).find(params[:id])
  end

  def authorize_user!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @spot.user_id == current_user.id
  end

  def spot_params
    params.require(:spot).permit(:title, :description, :price, images_attributes: [:url])
  end

  def set_cache_control_headers
    expires_in 1.hour, public: true
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
