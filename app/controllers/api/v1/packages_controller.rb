module Api
  module V1
    class PackagesController < ApplicationController
      before_action :set_package, only: [:show, :update, :destroy]
      before_action :check_admin, only: [:create, :destroy]

      def index
        packages = Package.all
        render json: PackageSerializer.new(packages, options).serialized_json
      end

      def show
        render json: PackageSerializer.new(@package, options).serialized_json
      end

      def create
        package = Package.new(package_params)

        if package.save
          render json: PackageSerializer.new(package).serialized_json
        else
          render json: { error: package.errors.messages }, status: 422
        end
      end

      def update
        if @package
          if @package.update(package_params)
            render json: PackageSerializer.new(@package, options).serialized_json
          else
            render json: { error: @package.errors.messages }, status: 422
          end
        else
          render json: { error: 'Package not found' }, status: :not_found
        end
      end

      def destroy
        if @package
          @package.destroy
          head :no_content
        else
          render json: { error: 'Package not found' }, status: 422
        end
      end

      private

      def check_admin
        unless current_user&.admin?
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end

      def package_params
        params.require(:package).permit(:name, :description, :image_url, :slug, :price)
      end

      def set_package
        @package = Package.find_by(slug: params[:slug])
      end

      def options
        @options ||= { include: %i[reservations] }
      end
    end
  end
end
