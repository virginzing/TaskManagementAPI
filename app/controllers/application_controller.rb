# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate_user
    token = request.headers['AuthenticationToken']

    user = User.find_by_email(token)

    return response_error('User not found.') unless user

    @current_user = user
  end

  def response_error(message)
    errors = message.is_a?(Array) ? message.join("\n") : message

    render json: { errors: errors }, status: :unprocessable_entity
  end
end
