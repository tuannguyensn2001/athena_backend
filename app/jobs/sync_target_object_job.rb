class SyncTargetObjectJob < ApplicationJob
  queue_as :default

  def perform(model, id)
    # Do something later

    object = get_object(model, id)
    Rails.logger.info "SyncTargetObjectJob: #{model} #{id} #{model}"
    target_object = TargetObject.where(target_id: id, target_type: model.downcase).first
    if target_object.present?
      target_object.properties = serializer(object).as_json
    else
      target_object = TargetObject.new
      target_object.properties = serializer(object).as_json
      target_object.target_type = model.downcase
      target_object.status = :active
      target_object.target_id = id
      target_object.save!
    end
  end

  private

  def get_object(model, id)
    return unless model == 'Workshop'

    Workshop.find(id)

  end

  def serializer(model)
    return unless model.instance_of? Workshop

    WorkshopSerializer.new(model)

  end
end
