# frozen_string_literal: true

describe Identity, type: :model do
  let(:user) { create(:user) }
  let(:identity) { create(:identity, user: user) }

  it 'belongs to an user' do
    expect(identity.user).to be_an_instance_of(User)
  end
end
