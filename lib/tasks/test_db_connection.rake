namespace :test_db_connection do
  desc 'Test db connection in test'
  task test_connection: :environment do

    return false unless Rails.env.test?

    Rails.logger.info ActiveRecord::Base.connection_db_config
    # Rails.logger.info Rails.application.config_for(:database)['test']

    #
    begin
      ActiveRecord::Base.connection
      puts 'Database connection successful!'
    rescue ActiveRecord::NoDatabaseError
      puts 'Database does not exist.'
    rescue ActiveRecord::ConnectionNotEstablished
      puts 'Failed to establish a database connection.'
    end
  end
end
