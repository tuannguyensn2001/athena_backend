module TimestampSerializer
  extend ActiveSupport::Concern

  included do
    def created_at
      object.created_at.to_i
    end

    def updated_at
      object.updated_at.to_i
    end
  end
end
