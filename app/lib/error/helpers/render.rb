# frozen_string_literal: true

# module Error::Helpers helps to format json
# module Error
module Error
  # module Helpers
  module Helpers
    # class to render json
    class Render
      def self.json(error, status, message)
        {
          status: status,
          error: error,
          message: message
        }.as_json
      end
    end
  end
end
