# frozen_string_literal: true

# describe Email, type: :model do
#   it 'validates email presence' do
#     model = described_class.create(location_type_id: 1)

#     model.email = 'test@test.com'
#     expect(model).to be_valid

#     model.email = nil
#     expect(model).not_to be_valid

#     model.email = ''
#     expect(model).not_to be_valid
#   end

#   it 'validates email format' do
#     model = described_class.create(location_type_id: 1)

#     model.email = 'test@test.com'
#     expect(model).to be_valid

#     model.email = 'test'
#     expect(model).not_to be_valid

#     model.email = 'test@test'
#     expect(model).to be_valid

#     model.email = 'test@'
#     expect(model).not_to be_valid
#   end

#   it 'validates location type id presence' do
#     model = described_class.create(email: 'test@tetst.com')

#     model.location_type_id = 1
#     expect(model).to be_valid

#     model.location_type_id = nil
#     expect(model).not_to be_valid

#     model.location_type_id = ''
#     expect(model).not_to be_valid
#   end
# end
