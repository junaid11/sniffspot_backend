# frozen_string_literal: true

FactoryBot.define do
  factory :spot do
    title { "something" }
    description { 'Anything' }
    price { 267 }
    user { create(:user) }
  end
end
