class PagesController < ApplicationController
  def index
    render json: { status: "It's working"}
  end
end
