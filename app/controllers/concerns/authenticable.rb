module Authenticable

  # get current user
  def current_user
    @current_user ||= User.find_by(auth_token: request_author_token)
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
           status: :unauthorized unless current_user.present?
  end

  private
  def request_author_token
    request.headers['Authorization']
  end
end