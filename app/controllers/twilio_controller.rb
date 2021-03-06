# frozen_string_literal: true

# Create a external API calls using Twilio.
class TwilioController < ApplicationController
  def sms
    result = send_sms_to_recipent

    if result.success?
      render json: { sms_sent: true }
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def email
    sent = send_email

    if sent.success?
      render json: { email_delivered: true }
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  def send_sms_to_recipent
    Twilio::Sms.new(
      params[:from_phone_number], params[:to_phone_number], params[:message]
    ).call
  end

  def send_email
    Twilio::Email.new(
      params[:from], params[:subject], params[:to], params[:content]
    ).call
  end
end
