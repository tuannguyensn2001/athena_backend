this_dir = File.expand_path('../..', File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib', 'protobuf')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
Dir.glob(File.join(lib_dir, '**', '*.rb')).each do |file|
  require file
end
# # require './app/grpc/auth_handler.rb'
#
# Rails.logger.info "init grpc"
