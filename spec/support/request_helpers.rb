module RequestHelpers
  def json
    JSON.parse(response.body)
  end

  def authenticate(user)
    auth_token = JsonWebToken.encode(user_id: user.id)
    request.headers['Authorization'] = "Bearer #{auth_token}"
  end

  def create_spot(title:, description:, images:, price:)
    post api_v1_spots_path, params: { spot: { title: title, description: description, images: images, price: price } }
  end

  def update_spot(spot_id:, title: nil, description: nil, images: nil, price: nil)
    put api_v1_spot_path(spot_id), params: { spot: { title: title, description: description, images: images, price: price } }
  end

  def delete_spot(spot_id)
    delete api_v1_spot_path(spot_id)
  end

  def create_review(spot_id:, rating:, comment: nil)
    post api_v1_spot_reviews_path(spot_id), params: { review: { rating: rating, comment: comment } }
  end

  def update_review(spot_id:, review_id:, rating: nil, comment: nil)
    put api_v1_spot_review_path(spot_id, review_id), params: { review: { rating: rating, comment: comment } }
  end

  def delete_review(spot_id:, review_id:)
    delete api_v1_spot_review_path(spot_id, review_id)
  end
end
