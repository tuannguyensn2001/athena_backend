namespace :grpc do
  desc 'TODO'
  task start_server: :environment do
    Rails.logger = Logger.new(STDOUT)

    this_dir = File.expand_path('../..', File.dirname(__FILE__))
    lib_dir = File.join(this_dir, 'lib', 'protobuf')
    app_dir = File.join(this_dir, 'app', 'grpc')
    $LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

    require 'grpc'
    Dir.glob(File.join(lib_dir, '**', '*.rb')).each do |file|
      require file
    end

    def main
      s = GRPC::RpcServer.new
      s.add_http2_port('0.0.0.0:40000', :this_port_is_insecure)
      s.handle(AuthHandler)
      Rails.logger.info 'server is running'
      
      s.run_till_terminated_or_interrupted([1, 'int', 'SIGTERM'])
    end

    main

  end

end
