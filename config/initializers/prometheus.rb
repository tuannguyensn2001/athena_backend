unless Rails.env.test?
  require 'prometheus_exporter/middleware'
  require './app/middleware/metric_middleware.rb'

  # This reports stats per request like HTTP status and timings

  Rails.application.middleware.unshift MetricMiddleware
end


