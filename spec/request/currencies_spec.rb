require 'rails_helper'

RSpec.describe 'Currencies API', type: :request do
  let(:user) { create(:user) }
  let!(:currencies) { create_list(:currency, 2) }
  let(:currency_id) { currencies.first.id }
  let(:headers) { valid_headers }

  # GET /currencies
  describe 'GET /currencies' do
    before { get '/currencies', params: {}, headers: headers }

    it 'returns currencies' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # GET /currencies/:id
  describe 'GET /currencies/:id' do
    before { get "/currencies/#{currency_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the currency' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(currency_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:currency_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Currency/)
      end
    end
  end
end
