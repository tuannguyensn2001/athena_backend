class BaseService
  attr_reader :current_user

  def initialize(*args)
    @errors = []
    @current_user = nil
  end

  def add_error(error)
    if error.is_a?(Array)
      error.each do |e|
        @errors << e
      end
      return
    end
    @errors << error
  end

  def error?
    @errors.any?
  end

  def success?
    !error?
  end

  def errors
    @errors
  end

  def auth_context
    AuthContext.new(user: current_user)
  end

end
