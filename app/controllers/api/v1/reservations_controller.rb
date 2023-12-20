module Api
  module V1
    class ReservationsController < ApplicationController

      def index
        package = Package.find_by(slug: params[:package_slug])

        if package
          reservations = Reservation.where(package: package)
          render json: reservations, each_serializer: ReservationSerializer, status: :ok
        else
          render json: { error: 'Package not found' }, status: :not_found
        end
      end

      def show
        if  @reservation.user.id == @current_user.id
          render json: { reservation: @reservation, message: 'reservation'
          }, status: ok
        else
          render json: { errors: "This reservation does not belong to this user" }, status: :forbidden
        end
      end

      def reservations
        reservations = @current_user.reservations
        @reservations_output = []

        reservations.each do |reservation|
          x = {
            reservation: reservation.as_json.merge(packageDetails: reservation.package.title),
            package: reservation.package.as_json
          }
          @reservations_output << x
        end

        render json: @reservations_output, status: :ok
      end

      def create
        reservations = Reservation.where(package: package)
        # reservations = @current_user.reservations
        package = Package.find_by(slug: params[:package_slug])
        reservation = package.reservations.build(reserve_params.merge(user: @current_user))
        # reservation = Reservation.new(reservation_params)

        if  reservation.save
          render json: ReservationSerializer.new(reservation).serialized_json
        else
          render json: {error: reservation.errors.messages}, status: 422
        end
      end

      def destroy

        reservation = Reservation.find(reservation_params)

        if reservation.destroy
          head :no_content
        else
          render json: {error: reservation.errors.messages}, status: 422
        end
      end
      private

      def reservation_params
        params.require(:reservation).permit(:user_id, :package_id, :location, :date)
      end
    end
  end
end
