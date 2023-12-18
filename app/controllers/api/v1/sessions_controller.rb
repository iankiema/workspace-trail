module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:user][:email])
        if user&.authenticate(params[:user][:password])
          render json: {
            message: 'User is logged in',
            user: UserSerializer.new(user),
            token: JsonWebToken.encode({ sub: user.id })
          }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      def auto_login
        token = params[:token]
        user = User.find(JWT.decode(token, "put your secret password here", true, algorithm: 'HS256')[0]["user_id"])
        render json: user
      end

      def logged_in
        if @current_user
          render json: {
            logged_in: true,
            user: @current_user
          }
        else
          render json: {
            logged_in: false
          }
        end
      end

      def logout
        reset_session
        render json: {status: 200, logged_out: true}
      end

      private

      def user_login_params
        params.require(:user).permit(:email, :password)
      end
   end
  end
end
