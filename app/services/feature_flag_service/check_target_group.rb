module FeatureFlagService
  class CheckTargetGroup < BaseService
    def initialize(target_group, target_object)
      super
      @target_group = target_group
      @target_object = target_object
    end

    def call
      marked = []

      conditions.each do |condition|
        marked << check_condition(condition)
      end

      operator = wrapper_conditions[:operator]
      if operator == 'and'
        marked.all?(true)
      elsif operator == 'or'
        marked.any?(true)
      else
        false
      end
    end

    def properties
      @target_object.tags = {} unless @target_object.tags.is_a?(Hash)
      @target_object.properties.merge(@target_object.tags)
    end

    def check_condition(condition)
      attribute = CustomAttribute.where(name: condition[:field], target_type: @target_group.target_type).first
      return true unless attribute&.visible

      field = condition[:field]
      operator = condition[:operator]
      value = condition[:value]
      case operator
      when '='
        properties[field] == value
      when '!='
        properties[field] != value
      when 'include'
        properties[field].include?(value)
      when 'exclude'
        !properties[field].include?(value)
      when 'in'
        value.include?(properties[field])
      when 'not_in'
        !value.include?(properties[field])
      when '>'
        properties[field].to_i > value.to_i
      when '>='
        properties[field].to_i >= value.to_i
      when '<'
        properties[field].to_i < value.to_i
      when '<='
        properties[field].to_i <= value.to_i
      when 'exist'
        properties[field].present?
      when 'not_exist'
        properties[field].blank?
      when 'match'
        properties[field].match?(value)
      when 'not_match'
        !properties[field].match?(value)
      else
        false
      end
    end

    def conditions
      wrapper_conditions[:list]
    end

    def wrapper_conditions
      @target_group.conditions.deep_symbolize_keys
    end
  end
end
