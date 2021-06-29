# frozen_string_literal: true

describe Family, type: :model do
  let(:family) { create(:family) }
  let(:person) { create(:person) }
  let(:family_member) do
    create(:family_member, family_id: family.id, person_id: person.id)
  end

  it 'returns family by person id' do
    family_member.reload
    described_class.by_person_id(person.id).should include(family)
  end
end
