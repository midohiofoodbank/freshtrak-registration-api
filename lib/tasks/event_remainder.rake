# frozen_string_literal: true

require 'net/http'

namespace :event do
  desc 'event remainder'
  task event_remainder: :environment do
    Reservation.send_remainders
  end
end
