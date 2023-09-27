module Api
  class Base < Grape::API
    format :json
    prefix :api

    # mount Api::V1::Auth
    # mount Api::V1::Workshop

    Dir[File.join(Rails.root, "app", "controllers", "api", "v1", "*.rb")].each do |file|
      module_name = File.basename(file, '.rb').camelize
      mount "Api::V1::#{module_name}".constantize
    end
  end
end
