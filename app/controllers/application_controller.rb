class ApplicationController < ActionController::API
  before_action :authenticate!

  private

  attr_reader :current_user

  # Stand-in for the platform's real authentication. Callers identify
  # themselves with an `X-User-Id` header; unknown or missing ids get a 401.
  # Authorization (who may see or do what) is deliberately NOT implemented.
  def authenticate!
    @current_user = User.find_by(id: request.headers["X-User-Id"])
    head :unauthorized unless @current_user
  end
end
