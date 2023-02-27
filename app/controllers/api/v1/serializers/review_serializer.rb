# app/serializers/review_serializer.rb
class Api::V1::Serializers::ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :comment
end
