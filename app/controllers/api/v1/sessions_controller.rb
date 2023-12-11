class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  respond_to :json

  def create
    user = warden.authenticate(auth_options)
    if user
      sign_in(resource_name, user)
      render json: { user: user, status: :ok }
    else
      render json: { error: 'Invalid credentials', status: :unauthorized }
    end
  end

  def destroy
    sign_out(resource_name)
    render json: { status: :ok }
  end
end
