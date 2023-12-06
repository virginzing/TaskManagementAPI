class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate_user
    token = request.headers['Authorization']

    user = User.find_by_email(token)

    return response_error('User not found.') unless user

    @current_user = user
  end

  def response_error(message)
    render json: { errors: message }, status: :unprocessable_entity
  end
end
