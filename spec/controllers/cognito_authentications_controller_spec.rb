# frozen_string_literal: true

describe CognitoAuthenticationsController, type: :controller do
  context 'with authenticated requests for new user signup' do
    let(:pantry_track_client) { instance_double(PantryTrak::Client) }

    before do
      allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
      allow(pantry_track_client).to receive(:create_user)
      allow(pantry_track_client).to receive(:create_reservation)
      allow(Reservation).to receive(:sync_to_pantry_trak)
    end

    it 'Creates a new user after signup' do
      token = ENV['TOKEN']
      cognito_sign_in(token)
      post '/cognito_authentications/user_signup'
      expect(response.status).to eq(201)
    end
  end

  context 'with authenticated requests' do
    let(:pantry_track_client) { instance_double(PantryTrak::Client) }

    before do
      allow(PantryTrak::Client).to receive(:new).and_return(pantry_track_client)
      allow(pantry_track_client).to receive(:create_user)
      allow(pantry_track_client).to receive(:create_reservation)
      allow(Reservation).to receive(:sync_to_pantry_trak)
      token = ENV['TOKEN']
      cognito_sign_in(token)
      post '/cognito_authentications/user_signup'
    end

    it 'Fetches users data' do
      get '/cognito_authentications/user_data'
      expect(response.status).to eq(200)
    end

    it 'Add user data and creates reservation' do
      post '/cognito_authentications/user_add_details', params: {
        'user':
        {
          'first_name' => 'Test',
          'middle_name' => 'one',
          'last_name' => 'day',
          'suffix' => 'SR',
          'date_of_birth' => '1989-04-02',
          'gender' => 'male',
          'address_line_1' => '1235 K St',
          'address_line_2' => '',
          'city' => '',
          'state' => '',
          'zip_code' => '',
          'phone' => '',
          'permission_to_text' => false,
          'email' => '',
          'permission_to_email' => false,
          'seniors_in_household' => '0',
          'adults_in_household' => '0',
          'children_in_household' => '0',
          'license_plate' => 'KL01AZ7252'
        },
        'reservation':
        {
          'event_date_id' => 1
        }
      }, formart: :json
      hash_body = JSON.parse(response.body)
      expect(hash_body['status_code']).to eq(200)
    end
  end
end
