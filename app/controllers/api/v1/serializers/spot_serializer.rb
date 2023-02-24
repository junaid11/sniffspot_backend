class Api::V1::SpotSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price

  has_many :images
  has_many :reviews
end
