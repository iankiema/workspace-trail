class ApplicationController < ActionController::API
  include ActionController::Cookies
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
end
