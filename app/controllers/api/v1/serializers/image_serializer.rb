# app/serializers/image_serializer.rb
class ImageSerializer < ActiveModel::Serializer
  attributes :id, :url
end