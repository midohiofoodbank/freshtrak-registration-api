# frozen_string_literal: true

describe Reservation, type: :model do
  let(:user) { User.create(user_type: :guest) }
  let(:reservation) { described_class.create(user: user, event_date_id: 1) }
  let(:start_time) { Time.current + 1.day }
  let(:message) { 'sms text' }
  let(:details) do
    { reservation: reservation, event_dates: {},
      start_time: start_time, message: message }
  end

  it 'sending remainders' do
    described_class.create(user: user, event_date_id: 1)
    allow(described_class).to receive(:send_reservstion_remainder)

    described_class.send_remainders
    expect(described_class).to have_received(:send_reservstion_remainder)
  end

  it 'send reservstion remainder' do
    allow(described_class).to receive(:fetch_event_info)
      .and_return({ '1' => {} })
    allow(described_class).to receive(:check_and_send_remainder)

    described_class.send_reservstion_remainder(details)
    expect(described_class).to have_received(:fetch_event_info)
    expect(described_class).to have_received(:check_and_send_remainder)
  end

  it 'check and send remainder' do
    details[:event_date_data] = { event_date: {} }
    allow(described_class).to receive(:get_event_time) { Time.current }
    allow(described_class).to receive(:send_remainder)
    described_class.check_and_send_remainder(details)
    expect(described_class).to have_received(:get_event_time)
    expect(described_class).to have_received(:send_remainder)
  end

  context 'when get event time' do
    let(:event_date) { { 'date' => '2020-01-04', 'start_time' => '12 AM' } }
    let(:expected1) { Time.strptime('2020-01-04 12 AM', '%F %I %p') }
    let(:expected2) { Time.strptime('2020-01-04 12:30 AM', '%F %I:%M %p') }

    it 'get event time with hour' do
      expect(described_class.get_event_time(event_date)).to eq(expected1)
    end

    it 'get event time with hour and minutes' do
      event_date['start_time'] = '12:30 AM'
      expect(described_class.get_event_time(event_date)).to eq(expected2)
    end
  end

  context 'when send remainder' do
    let(:twilio_sms) { instance_double(Twilio::Sms) }

    before do
      allow(Twilio::Sms).to receive(:new).and_return(twilio_sms)
      allow(twilio_sms).to receive(:call)
        .and_return(OpenStruct.new(success?: true))
    end

    it 'when to number is present and send_sms flag is true' do
      described_class.send_remainder(reservation, '12345',
                                     '67890', 'message', true)
      expect(twilio_sms).to have_received(:call)
    end

    it 'when to number is not present and send_sms flag is true' do
      described_class.send_remainder(reservation, '12345',
                                     nil, 'message', true)
      expect(twilio_sms).not_to have_received(:call)
    end

    it 'when to number is present and send_sms flag is false' do
      described_class.send_remainder(reservation, '12345',
                                     '67890', 'message', false)
      expect(twilio_sms).not_to have_received(:call)
    end

    it 'when to number is not present and send_sms flag is false' do
      described_class.send_remainder(reservation, '12345',
                                     nil, 'message', false)
      expect(twilio_sms).not_to have_received(:call)
    end
  end

  context 'when fetch_event_info' do
    let(:event_date_id) { '123' }
    let(:event_dates) { {} }
    let(:success_response1) { Net::HTTPSuccess.new(1.0, '200', 'OK') }
    let(:success_response2) { Net::HTTPSuccess.new(1.0, '200', 'OK') }
    let(:error_response) { Net::HTTPError.new('Error', '403') }

    before do
      allow(described_class).to receive(:update_cached_event_details)
    end

    it 'call update_cached_event_details with success response1' do
      allow(success_response1).to receive(:body).and_return('{"events": [{}]}')
      allow(Net::HTTP).to receive(:get_response).and_return(success_response1)

      described_class.fetch_event_info(event_dates, event_date_id)
      expect(described_class)
        .to have_received(:update_cached_event_details)
    end

    it 'not call update_cached_event_details with error response' do
      allow(Net::HTTP).to receive(:get_response).and_return(error_response)

      described_class.fetch_event_info(event_dates, event_date_id)
      expect(described_class)
        .not_to have_received(:update_cached_event_details)
    end
  end

  context 'when update_cached_event_details' do
    let(:event) do
      { 'event_dates' => ['event_date'],
        'twilio_phone_number' => '9876543210' }
    end
    let(:event2) do
      { 'event_dates' => [],
        'twilio_phone_number' => '9876543210' }
    end
    let(:expected1) do
      { '1' => { event_date: 'event_date',
                 twilio_phone_number: '9876543210' } }
    end

    it 'event date is available' do
      expect(described_class.update_cached_event_details({}, '1', [event]))
        .to eq(expected1)
    end

    it 'event date is not available' do
      expect(described_class.update_cached_event_details({}, '1', [event2]))
        .to eq({})
    end
  end
end
