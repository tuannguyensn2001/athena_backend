class TargetGroup < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  validate :validate_condition

  enum target_type: {
    workshop: 'workshop',
    user: 'user',
    member: 'member'
  }

  def validate_condition
    schema = {
      "type": 'object',
      "properties": {
        "operator": {
          "type": 'string',
          "enum": ['and', 'or']
        },
        "list": {
          "type": 'array',
          "items": {
            "type": 'object',
            "properties": {
              "field": {
                "type": 'string'
              },
              "operator": {
                "type": 'string',
              },
              "value": {
                "type": 'string'
              }
            },
            "required": %w[field operator]
          }
        }
      },
      "required": %w[operator list]
    }
    errors.add(:conditions, 'is not valid') unless JSON::Validator.validate(schema, conditions)
  end
end
