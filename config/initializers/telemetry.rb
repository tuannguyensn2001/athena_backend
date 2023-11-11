require 'opentelemetry/sdk'
require 'opentelemetry/instrumentation/all'
require 'opentelemetry-exporter-otlp'

if Rails.env.development?
  OpenTelemetry::SDK.configure do |c|
    c.service_name = 'athena'
    # c.use_all() # enables all in
    c.use_all
    # c.use 'OpenTelemetry::Instrumentation::ActiveRecord'
    # c.use 'OpenTelemetry::Instrumentation::Http'

  end
end
