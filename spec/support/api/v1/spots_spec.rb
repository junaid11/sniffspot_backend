require 'rails_helper'

RSpec.describe 'API::V1::Spots', type: :request do
  describe 'GET /api/v1/spots' do
    let!(:spots) { create_list(:spot, 3) }

    context 'when sending a valid request' do
        before { get api_v1_spots_path }
  
        it 'returns a list of spots' do
          expect(json['data'].size).to eq(3)
        end
  
        it 'matches the JSON schema for the response' do
          expect(response).to match_response_schema(api_schema.index_response_schema)
        end
  
        it 'returns a 200 status code' do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  
    describe 'GET /api/v1/spots/:id' do
      let(:spot) { create(:spot) }
  
      context 'when sending a valid request' do
        before { get api_v1_spot_path(spot.id) }
  
        it 'returns the requested spot' do
          expect(json['data']['id']).to eq(spot.id.to_s)
        end
  
        it 'matches the JSON schema for the response' do
          expect(response).to match_response_schema(api_schema.show_response_schema)
        end
  
        it 'returns a 200 status code' do
          expect(response).to have_http_status(:ok)
        end
      end
  
      context 'when sending an invalid request' do
        before { get api_v1_spot_path(-1) }
  
        it 'returns a 404 status code' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  
    describe 'POST /api/v1/spots' do
      let(:user) { create(:user) }
  
      context 'when sending a valid request' do
        before { authenticate(user) }
  
        it 'creates a new spot' do
          expect { create_spot(title: 'New Spot', description: 'A new spot', images: [{ url: 'https://example.com/image.jpg' }], price: 100) }
            .to change { Spot.count }.by(1)
        end
  
        it 'matches the JSON schema for the response' do
          create_spot(title: 'New Spot', description: 'A new spot', images: [{ url: 'https://example.com/image.jpg' }], price: 100)
          expect(response).to match_response_schema(api_schema.show_response_schema)
        end
  
        it 'returns a 201 status code' do
          create_spot(title: 'New Spot', description: 'A new spot', images: [{ url: 'https://example.com/image.jpg' }], price: 100)
          expect(response).to have_http_status(:created)
        end
      end
  
      context 'when sending an invalid request' do
        before { authenticate(user) }
  
        it 'does not create a new spot' do
          expect { create_spot(title: '', description: '', images: [], price: 100) }
            .not_to change { Spot.count }
        end
  
        it 'returns a 422 status code' do
          create_spot(title: '', description: '', images: [], price: 100)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
  
      context 'when not authenticated' do
        it 'returns a 401 status code' do
          create_spot(title: 'New Spot', description: 'A new spot', images: [{ url: 'https://example.com/image.jpg' }], price: 100)
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  
    describe 'PUT /api/v1/spots/:id' do
        let(:user) { create(:user) }
        let(:spot) { create(:spot, user: user) }
    
        context 'when sending a valid request' do
          before { authenticate(user) }
    
          it 'updates the spot' do
            put api_v1_spot_path(spot.id), params: { title: 'Updated Spot', price: 200 }
            expect(spot.reload.title).to eq('Updated Spot')
            expect(spot.reload.price).to eq(200)
          end
    
          it 'matches the JSON schema for the response' do
            put api_v1_spot_path(spot.id), params: { title: 'Updated Spot', price: 200 }
            expect(response).to match_response_schema(api_schema.show_response_schema)
          end
    
          it 'returns a 200 status code' do
            put api_v1_spot_path(spot.id), params: { title: 'Updated Spot', price: 200 }
            expect(response).to have_http_status(:ok)
          end
        end
    
        context 'when sending an invalid request' do
          before { authenticate(user) }
    
          it 'does not update the spot' do
            put api_v1_spot_path(spot.id), params: { title: '', price: 200 }
            expect(spot.reload.title).not_to eq('')
            expect(spot.reload.price).not_to eq(200)
          end
    
          it 'returns a 422 status code' do
            put api_v1_spot_path(spot.id), params: { title: '', price: 200 }
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
    
        context 'when not authenticated' do
          it 'returns a 401 status code' do
            put api_v1_spot_path(spot.id), params: { title: 'Updated Spot', price: 200 }
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    
      describe 'DELETE /api/v1/spots/:id' do
        let(:user) { create(:user) }
        let(:spot) { create(:spot, user: user) }
    
        context 'when sending a valid request' do
          before { authenticate(user) }
    
          it 'deletes the spot' do
            expect { delete api_v1_spot_path(spot.id) }.to change { Spot.count }.by(-1)
          end
    
          it 'returns a 204 status code' do
            delete api_v1_spot_path(spot.id)
            expect(response).to have_http_status(:no_content)
          end
        end
    
        context 'when not authenticated' do
          it 'returns a 401 status code' do
            delete api_v1_spot_path(spot.id)
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    
      describe 'POST /api/v1/spots/:id/reviews' do
        let(:user) { create(:user) }
        let(:spot) { create(:spot) }
    
        context 'when sending a valid request' do
          before { authenticate(user) }
    
          it 'creates a new review' do
            expect { create_review(spot_id: spot.id, user_id: user.id, rating: 3, body: 'Nice spot') }
              .to change { Review.count }.by(1)
          end
    
          it 'returns a 201 status code' do
            create_review(spot_id: spot.id, user_id: user.id, rating: 3, body: 'Nice spot')
            expect(response).to have_http_status(:created)
          end
        end
    
        context 'when sending an invalid request' do
          before { authenticate(user) }
    
          it 'does not create a new review' do
            expect { create_review(spot_id: spot.id, user_id: user.id, rating: 10, body: '') }
              .not_to change { Review.count }
          end
    
          it 'returns a 422 status code' do
            create_review(spot_id: spot.id, user_id: user.id, rating: 10, body: '')
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
    
        context 'when not authenticated' do
          it 'returns a 401 status code' do
            create_review(spot_id: spot.id, user_id: user.id, rating: 3, body: 'Nice spot')
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    
      describe 'PUT /api/v1/spots/:spot_id/reviews/:id' do
        let(:user) { create(:user) }
        let(:spot) { create(:spot) }
        let(:review) { create(:review, user: user, spot: spot) }
    
        context 'when sending a valid request' do
          before { authenticate(user) }
    
          it 'updates the review' do
            put api_v1_spot_review_path(spot_id: spot.id, id: review.id), params: { body: 'Updated body' }
            expect(review.reload.body).to eq('Updated body')
          end
    
          it 'matches the JSON schema for the response' do
            put api_v1_spot_review_path(spot_id: spot.id, id: review.id), params: { body: 'Updated body' }
            expect(response).to match_response_schema(api_schema.show_review_response_schema)
          end
    
          it 'returns a 200 status code' do
            put api_v1_spot_review_path(spot_id: spot.id, id: review.id), params: { body: 'Updated body' }
            expect(response).to have_http_status(:ok)
          end
        end
    
        context 'when sending an invalid request' do
          before { authenticate(user) }
    
          it 'does not update the review' do
            put api_v1_spot_review_path(spot_id: spot.id, id: review.id), params: { body: '' }
            expect(review.reload.body).not_to eq('')
          end
    
          it 'returns a 422 status code' do
            put api_v1_spot_review_path(spot_id: spot.id, id: review.id), params: { body: '' }
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
    
        context 'when not authenticated' do
          it 'returns a 401 status code' do
            put api_v1_spot_review_path(spot_id: spot.id, id: review.id), params: { body: 'Updated body' }
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    
      describe 'DELETE /api/v1/spots/:spot_id/reviews/:id' do
        let(:user) { create(:user) }
        let(:spot) { create(:spot) }
        let(:review) { create(:review, user: user, spot: spot) }
    context 'when sending a valid request' do
      before { authenticate(user) }

      it 'deletes the review' do
        delete api_v1_spot_review_path(spot_id: spot.id, id: review.id)
        expect(Review.exists?(review.id)).to be_falsy
      end

      it 'returns a 204 status code' do
        delete api_v1_spot_review_path(spot_id: spot.id, id: review.id)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when not authenticated' do
      it 'returns a 401 status code' do
        delete api_v1_spot_review_path(spot_id: spot.id, id: review.id)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

    