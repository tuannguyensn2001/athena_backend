namespace :user do
  desc "TODO"
  task :set_admin, [:phone] => :environment do |t, args|
    Rails.logger = Logger.new(STDOUT)
    Rails.application.eager_load!
    Rails.logger.info "phone: #{args[:phone]}"
    User.where(phone: args[:phone]).first.update(is_admin: true)
    Rails.logger.info "update success"
  end

end
