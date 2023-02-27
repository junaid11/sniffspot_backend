class Api::V1::Serializers::SpotSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user_id , :price

  has_many :images
  has_many :reviews
end
