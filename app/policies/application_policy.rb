class ApplicationPolicy
  attr_reader :context, :current_user

  def initialize(context)
    @context = context
    @current_user = context.user
  end


end
