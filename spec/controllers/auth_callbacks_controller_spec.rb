# frozen_string_literal: true

describe AuthCallbacksController, type: :controller do
  let(:facebook_api) { instance_double(FacebookApi) }

  context 'with new user requests' do
    before do
      allow(FacebookApi).to receive(:new).and_return(facebook_api)
      allow(facebook_api).to receive(:facebook_auth)
        .and_return(true)
    end

    it 'creates user record on post' do
      expect { post 'auth_callbacks/facebook', params: params }
        .to change(User, :count).by(1)
    end

    it 'creates authentication on post' do
      expect { post 'auth_callbacks/facebook', params: params }
        .to change(Authentication, :count).by(1)
    end

    it 'creates identity record on post' do
      expect { post 'auth_callbacks/facebook', params: params }
        .to change(Identity, :count).by(1)
    end
  end

  context 'with returning user requests' do
    let!(:user) { create(:user) }
    let(:identity) { create(:identity, user: user) }
    let!(:authentication) { create(:authentication, user: user) }

    before do
      allow(FacebookApi).to receive(:new).and_return(facebook_api)
      allow(facebook_api).to receive(:facebook_auth)
        .and_return(true)
    end

    it 'uses existing authentication token of that user' do
      post 'auth_callbacks/facebook', params: existing_params
      expect(JSON.parse(response.body)['token']).to eq(authentication.token)
    end
  end

  context 'with invalid facebook api' do
    before do
      allow(FacebookApi).to receive(:new).and_return(facebook_api)
      allow(facebook_api).to receive(:facebook_auth)
        .and_return(false)
    end

    it 'responds with "unprocessable entity"' do
      post 'auth_callbacks/facebook', params: params
      expect(response.status).to eq(422)
    end
  end

  def params
    {
      userID: 'provider_uid', graphDomain: 'facebook',
      accessToken: 'auth_hash'
    }
  end

  def existing_params
    {
      userID: identity['provider_uid'],
      graphDomain: 'facebook',
      accessToken: identity['auth_hash']
    }
  end
end
