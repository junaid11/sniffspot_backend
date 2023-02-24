require_relative './serializers/review_serializer'

module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :set_review, only: [:show, :update, :destroy]
      before_action :set_spot
      before_action :set_review, only: [:update, :destroy]

      def index
        reviews = Review.all
        render json: reviews, each_serializer: Api::V1::ReviewSerializer
      end

      def show
        render json: @review, serializer: Api::V1::ReviewSerializer
      end

      def create
        @review = @spot.reviews.build(review_params)
        if @review.save
          render json: @review, status: :created
        else
          render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @review.update(review_params)
          render json: @review, status: :ok
        else
          render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @review.destroy
        head :no_content
      end

      private

      def review_params
        params.require(:review).permit(:rating, :comment)
      end

      def set_spot
        @spot = Spot.find(params[:spot_id])
      end

      def set_review
        @review = @spot.reviews.find(params[:id])
      end
    end
  end
end
