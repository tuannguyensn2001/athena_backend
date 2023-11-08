namespace :target_object do
  desc 'TODO'
  task sync_workshop: :environment do
    Rails.application.eager_load!
    Rails.logger = Logger.new(STDOUT)

    Workshop.find_each do |workshop|
      Rails.logger.info "Syncing workshop #{workshop.id}"
      SyncTargetObjectJob.perform_now('Workshop', workshop.id)
    end
  end

end
