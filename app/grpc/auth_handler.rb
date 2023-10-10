class AuthHandler < Protobuf::Auth::Service
  def verify(req, u)
    service = AuthService::Verify.new(req.token)
    result = service.call
    # if service.success?
    Protobuf::VerifyResponse.new(message: 'success', user: Protobuf::User.new(id: 1, email: 'a'))
    #   Protobuf::VerifyResponse.new(message: 'success',user: Protobuf::User.new(id: User.first.id,email: User.first.email))
    # else
    #   Protobuf::VerifyResponse.new(message: 'success',user: Protobuf::User.new(id: User.first.id,email: User.first.email))
    # end
  end
end
