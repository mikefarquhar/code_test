module AuthHelpers
  # Headers that authenticate a request as `user` against the stubbed auth.
  def auth_headers(user)
    { "X-User-Id" => user.id.to_s }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
end
