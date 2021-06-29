# frozen_string_literal: true

describe Api::AddressesController, type: :controller do
  context 'with authenticated requests' do
    let(:token) { ENV['TOKEN'] }
    let!(:user) { create(:user) }
    # let(:identity) { create(:identity, user: user) }
    let(:person) { create(:person, user: user) }
    let(:address_contact) do
      create(:contact, contact_type: 'address', person: person)
    end
    let!(:address) { create(:address, contact: address_contact) }

    before do
      create(:identity, user: user)
      cognito_sign_in(token)
    end

    context 'with -> POST create' do
      it 'creates address of a user' do
        expect(Address.all.count).to eq 1
        post '/api/addresses', params: { address: {
          line_1: '915 south avenue', city: 'secane', state: 'PA',
          zip_code: '19018'
        } }
        expect(Address.all.count).to eq 2
      end

      it 'does not create an address with invalid params' do
        post '/api/addresses', params: { address: {
          line_1: '915 south avenue', city: 'secane', state: 'PAAAA',
          zip_code: '19018', contact_id: address_contact.id
        } }

        expect(response.status).to eq 422
        response_body = JSON.parse(response.body)
        response = response_body['errors']
        expect(response).to eq(
          { 'state' => ['is the wrong length (should be 2 characters)'] }
        )
      end
    end

    context 'with -> GET index' do
      it 'lists addresses of users' do
        get '/api/addresses'

        expect(response.status).to eq 200
        response_body = JSON.parse(response.body)
        response = response_body['address']
        expect(response).to eq(JSON.parse(address.to_json))
      end

      it 'responds with empty json if addresses not found' do
        Address.destroy(address.id)
        get '/api/addresses'

        expect(response.body).to eq '{}'
      end
    end

    context 'with -> GET show' do
      it 'renders addresses#show template' do
        get "/api/addresses/#{address.id}", params: { id: address.id }

        expect(response.status).to eq 200
        response_body = JSON.parse(response.body)
        response = response_body['address']
        expect(response).to eq(JSON.parse(address.to_json))
      end

      it 'responds with "record_not_found" if address does not exist' do
        get "/api/addresses/#{address.id + 1}", params: { id: address.id + 1 }

        response_body = JSON.parse(response.body)
        expect(response.status).to eq 404
        expect(response_body['error']).to eq 'record_not_found'
        expect(response_body['message']).to eq(
          "Couldn't find Address with 'id'=8"
        )
      end
    end

    context 'with -> PUT update' do
      it 'updates an existing address' do
        put "/api/addresses/#{address.id}", params: {
          id: address.id, address: { line_1: '915 north avenue' }
        }

        expect(response.status).to eq 200
        response_body = JSON.parse(response.body)
        response = response_body['address']
        expect(response['line_1']).to eq '915 north avenue'
        expect(response).not_to eq(JSON.parse(address.to_json))
      end

      it 'does not update an address with invalid params' do
        put "/api/addresses/#{address.id}", params: {
          id: address.id, address: { state: 'PAAA' }
        }

        expect(response.status).to eq 422
        response_body = JSON.parse(response.body)
        response = response_body['errors']
        expect(response).to eq(
          { 'state' => ['is the wrong length (should be 2 characters)'] }
        )
      end

      it 'responds with "record_not_found" if wrong address_id in url' do
        put "/api/addresses/#{address.id + 1}", params: { id: address.id + 1 }

        response_body = JSON.parse(response.body)
        expect(response.status).to eq 404
        expect(response_body['error']).to eq 'record_not_found'
        expect(response_body['message']).to eq(
          "Couldn't find Address with 'id'=11"
        )
      end
    end

    context 'with -> DELETE action' do
      it 'delete address using id ' do
        delete "/api/addresses/#{address.id}", body: { id: 1 }
        response_body = JSON.parse(response.body)
        expect(response_body['deleted']).to eq(true)
      end

      it 'responds with "record_not_found" if address does not exist' do
        delete "/api/addresses/#{address.id + 1}", params: {
          id: address.id + 1
        }

        response_body = JSON.parse(response.body)
        expect(response.status).to eq 404
        expect(response_body['error']).to eq 'record_not_found'
        expect(response_body['message']).to eq(
          "Couldn't find Address with 'id'=13"
        )
      end
    end
  end

  context 'without authenticated requests' do
    context 'with -> GET index' do
      it 'responds with unauthorized' do
        get '/api/addresses'

        response_body = JSON.parse(response.body)
        expect(response_body['error']).to eq('invalid_auth')
      end
    end

    context 'with -> GET show' do
      it 'responds with unauthorized' do
        get '/api/addresses/1', params: { id: 1 }

        response_body = JSON.parse(response.body)
        expect(response_body['error']).to eq('invalid_auth')
      end
    end

    context 'with -> PUT update' do
      it 'responds with unauthorized' do
        put '/api/addresses/1', params: {
          id: 1, address: { line_1: '915 north avenue' }
        }

        response_body = JSON.parse(response.body)
        expect(response_body['error']).to eq('invalid_auth')
      end
    end

    context 'with -> DELETE action' do
      it 'responds with unauthorized' do
        delete '/api/addresses/1', body: { id: 1 }

        response_body = JSON.parse(response.body)
        expect(response_body['error']).to eq('invalid_auth')
      end
    end
  end
end
