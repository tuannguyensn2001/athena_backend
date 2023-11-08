namespace :workshop do
  desc "TODO"
  task :update_subscription_plan, [:workshop_id, :plan] => :environment do |t, args|
    Rails.application.eager_load!
    Rails.logger = Logger.new(STDOUT)

    target = args[:workshop_id].to_s
    plan = args[:plan]
    workshop = Workshop
    workshop = workshop.find(target) if target != 'all'
    workshop.update(subscription_plan: plan)
    Rails.logger.info "update success"
  end
end
