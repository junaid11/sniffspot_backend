class Spot < ApplicationRecord
  belongs_to :user
  
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
