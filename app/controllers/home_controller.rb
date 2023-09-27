class HomeController < ApplicationController
  def index
    render json: { message: "success", database: true }
  end
end
