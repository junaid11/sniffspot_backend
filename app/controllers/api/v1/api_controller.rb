module Api
  module V1
    class ApiController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
      rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
      rescue_from ActionController::ParameterMissing, with: :render_bad_request

      private

      def render_404
        render json: { error: 'Not found' }, status: :not_found
      end

      def render_unprocessable_entity(exception)
        render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
      end

      def render_bad_request
        render json: { error: 'Bad request' }, status: :bad_request
      end
    end
  end
end
