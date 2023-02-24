class ImagesController < ApplicationController
  before_action :set_spot

  def index
    @images = @spot.images
    render json: @images
  end

  def create
    @image = @spot.images.new(image_params)
    if @image.save
      render json: @image, status: :created
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  private

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def image_params
    params.require(:image).permit(:url)
  end
end
