class AuthController < ApplicationController
  def register
    service = AuthService::Register.new(params)
    service.call
    if service.success?
      render json: { message: 'User created successfully' }, status: :ok
    else
      render json: { message: service.errors }, status: :internal_server_error
    end
  end

  def login
    service = AuthService::Login.new(params)
    result = service.call
    if service.success?
      render json: { data: result }, status: :ok
    else
      render json: { message: service.errors }, status: :internal_server_error
    end
  end
end
