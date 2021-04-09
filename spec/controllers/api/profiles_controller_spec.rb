# frozen_string_literal: true

describe Api::ProfilesController, type: :controller do
  context 'with User Profiles Controller GET' do
    let(:user) do
      User.create(
        user_type: :guest,
        first_name: 'Harry',
        last_name: 'Potter',
        date_of_birth: '1993-01-24'
      )
    end
    let(:pantry_track_client) { instance_double(PantryTrak::Client) }

    before do
      allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
      allow(pantry_track_client).to receive(:create_user)
      allow(user).to receive(:sync_to_pantry_trak)
      sign_in_api(user)
    end

    it 'returns user details and JSON size' do
      get '/api/profiles/user_data'
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
      expect(hash_body['data'][0].length).to eq(8)
    end

    it 'returns user address details and JSON size' do
      get '/api/profiles/user_address'
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
      expect(hash_body['data'][0].length).to eq(5)
    end

    it 'returns user contact details and JSON size' do
      get '/api/profiles/user_contact_details'
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
      expect(hash_body['data'][0].length).to eq(2)
    end

    it 'returns user vehicle details and JSON size' do
      get '/api/profiles/user_vehicle_details'
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
      expect(hash_body['data'][0].length).to eq(1)
    end
  end

  context 'with User Profiles Controller PUT' do
    let(:user) do
      User.create(
        user_type: :guest,
        first_name: 'Harry',
        last_name: 'Potter',
        date_of_birth: '1993-01-24'
      )
    end
    let(:pantry_track_client) { instance_double(PantryTrak::Client) }

    before do
      allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
      allow(pantry_track_client).to receive(:create_user)
      allow(user).to receive(:sync_to_pantry_trak)
      sign_in_api(user)
    end

    it 'edits user details' do
      put '/api/profiles/update_user_data', user: {
        'first_name' => 'John',
        'middle_name' => 'J',
        'last_name' => 'J',
        'is_adult' => 1,
        'date_of_birth' => '1997-04-19',
        'race' => 'American',
        'ethnicity' => 'American',
        'gender' => 'male'
      }, formart: :json
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
    end

    it 'edits user address' do
      put '/api/profiles/update_user_data', user: {
        'address_line_1' => 'new address 1',
        'address_line_2' => 'new address 2',
        'city' => 'city',
        'state' => 'state',
        'zip_code' => '691523'
      }, formart: :json
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
    end

    it 'edits user contact details' do
      put '/api/profiles/update_user_data', user: {
        'phone' => '1234567890',
        'email' => 'newemai@gmail.com'
      }, formart: :json
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
    end

    it 'edits user vehicle details' do
      put '/api/profiles/update_user_data', user: {
        'license_plate' => 'new_vehicle_plate'
      }, formart: :json
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
    end

    it 'responds with unauthorized put' do
      put '/api/profiles/update_user_data', user: {
        'license' => 'new_vehicle_plate'
      }, formart: :json
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(500)
    end
  end
end