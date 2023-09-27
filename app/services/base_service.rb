class BaseService

  def initialize(*args)
    @errors = []
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

end
