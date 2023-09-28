class ApplicationPolicy
  attr_reader :context, :current_user, :current_workshop

  def initialize(context = nil)
    return unless context
    @context = context
    @current_user = context.user
    @current_workshop = context.workshop
  end

end
