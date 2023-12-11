class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      sign_up(resource_name, resource)
      render json: { user: resource, status: :ok }
    else
      render json: { error: resource.errors.full_messages, status: :unprocessable_entity }
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
