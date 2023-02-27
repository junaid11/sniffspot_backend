require 'rails_helper'

RSpec.describe Api::V1::SpotsController, type: :controller do
  describe 'GET #index' do
    let!(:spot1) { FactoryBot.create(:spot) }
    let!(:spot2) { FactoryBot.create(:spot) }

    it 'returns a list of spots' do
      get :index
      expect(assigns(:spots)).to match_array([spot1, spot2])
    end

    it 'returns a 200 status code' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    let!(:spot) { FactoryBot.create(:spot) }

    it 'returns the specified spot' do
      get :show, params: { id: spot.id }
      expect(assigns(:spot)).to eq(spot)
    end

    it 'returns a 200 status code' do
      get :show, params: { id: spot.id }
      expect(response).to have_http_status(:ok)
    end
  end

  # describe 'POST #create' do
  #   let(:user) { FactoryBot.create(:user) }
  #   let(:valid_attributes) do
  #     {
  #       spot: {
  #         title: 'Test spot',
  #         description: 'Test description',
  #         price: 10.0,
  #         user_id: user.id,
  #         images: [
  #           { url: 'http://example.com/image.jpg' },
  #         ]
  #       }
  #     }
  #   end

  #   context 'when the request is valid' do
  #     it 'creates a new spot' do
  #       expect {
  #         post :create, params: valid_attributes
  #       }.to change(Spot, :count).by(1)
  #     end

  #     it 'returns a 201 status code' do
  #       post :create, params: valid_attributes
  #       expect(response).to have_http_status(:created)
  #     end

  #     it 'returns the created spot' do
  #       post :create, params: valid_attributes
  #       expect(assigns(:spot)).to be_a(Spot)
  #       expect(assigns(:spot)).to be_persisted
  #       expect(assigns(:spot).title).to eq('Test spot')
  #       expect(assigns(:spot).description).to eq('Test description')
  #       expect(assigns(:spot).price).to eq(10.0)
  #       expect(assigns(:spot).user_id).to eq(user.id)
  #     end
  #   end

  #   context 'when the request is invalid' do
  #     let(:invalid_attributes) do
  #       {
  #         spot: {
  #           title: nil,
  #           description: nil,
  #           price: nil,
  #           user_id: nil,
  #           images: [{ url: 'http://example.com/image.jpg' }]
  #         }
  #       }
  #     end

  #     it 'does not create a new spot' do
  #       expect {
  #         post :create, params: invalid_attributes
  #       }.not_to change(Spot, :count)
  #     end

  #     it 'returns a 422 status code' do
  #       post :create, params: invalid_attributes
  #       expect(response).to have_http_status(:unprocessable_entity)
  #     end

  #     it 'returns the errors' do
  #       post :create, params: invalid_attributes
  #       expect(response.body).to include('Title can\'t be blank')
  #       expect(response.body).to include('Description can\'t be blank')
  #       expect(response.body).to include('Price can\'t be blank')
  #       expect(response.body).to include('User must exist')
  #     end
  #   end
  # end

end
   
