# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render json: { message: 'success', database: true }
  end
end
