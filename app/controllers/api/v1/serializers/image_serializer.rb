# app/serializers/image_serializer.rb
class Api::V1::Serializers::ImageSerializer < ActiveModel::Serializer
  attributes :id, :url
end