# frozen_string_literal: true

# Generalised Response Handlers
module Application
  # Response Handler
  module ResponseHandler
    extend ActiveSupport::Concern

    def serializer
      ActiveModelSerializers::SerializableResource
    end

    def render_set_collection(collection)
      data = collection
      render status: :ok, json: {
        status_code: 200,
        message: 'Data retrieved successfully',
        data: data
      }
    end

    def render_message(message, code)
      render status: :ok, json: {
        status_code: code,
        message: message
      }
    end

    def render_data(data, code, message)
      render status: :ok, json: {
        status_code: code,
        data: data,
        message: message
      }
    end

    def render_user_id(message, user, code)
      render json: {
        message: message,
        user: user
      }, status: code
    end
  end
end
