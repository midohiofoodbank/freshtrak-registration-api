# frozen_string_literal: true

# Error module to Handle errors globally
module Error
  # include Error::ErrorHandler in application_controller.rb
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:record_not_found, 404, capture_record_id(e))
        end
      end
    end

    private

    def respond(error, status, message)
      json = Helpers::Render.json(error, status, message)
      render json: json, status: status
    end

    def capture_record_id(msg)
      regex = Regexp.new('(.*?)\[', Regexp::IGNORECASE)
      return msg unless (matches = msg.as_json.match(regex))

      matches[1].strip
    end
  end
end
