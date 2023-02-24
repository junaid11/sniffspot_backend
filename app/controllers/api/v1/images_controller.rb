module Api
  module V1
    class ImagesController < ApplicationController
      before_action :set_spot

      def create
        @image = @spot.images.build(image_params)
        if @image.save
          render json: @image, status: :created
        else
          render json: { errors: @image.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def image_params
        params.require(:image).permit(:url)
      end

      def set_spot
        @spot = Spot.find(params[:spot_id])
      end
    end
  end
end
