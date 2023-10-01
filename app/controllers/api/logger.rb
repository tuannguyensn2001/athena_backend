# frozen_string_literal: true

module Api
  module Logger
    extend ActiveSupport::Concern

    included do
      helpers do
        def logger
          Rails.logger
        end
      end
    end
  end
end
