class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    user_id = request.headers["X-User-Id"]

    return render json: { error: "Unauthorized" }, status: :unauthorized unless user_id

    @current_user = User.find_by(id: user_id)

    return render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end
end
