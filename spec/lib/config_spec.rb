# frozen_string_literal: true

describe Config do
  let(:pantry_finder_api_url) { 'https://test.pantry-finder-api.freshtrak.com' }
  let(:fb_api_url) { 'https://graph.test.facebook.com' }

  context 'with PANTRY_FINDER_API_URL' do
    before do
      ENV['PANTRY_FINDER_API_URL'] = pantry_finder_api_url
    end

    it 'returns url' do
      expect(described_class.pantry_finder_api_url).to eq pantry_finder_api_url
    end
  end

  context 'with facebook_api_url' do
    before do
      ENV['FACEBOOK_API_URL'] = fb_api_url
    end

    it 'returns url' do
      expect(described_class.facebook_api_url).to eq fb_api_url
    end
  end
end
