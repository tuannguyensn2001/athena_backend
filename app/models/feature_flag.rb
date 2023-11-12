class FeatureFlag < ApplicationRecord

  validates :code, presence: true, uniqueness: true
  validates :state, presence: true
  validates :target_type, presence: true

  validate :validate_condition

  has_many :feature_flag_objects, dependent: :destroy
  has_many :target_objects, through: :feature_flag_objects

  enum state: {
    # public: 'public',
    open_beta: 'open_beta',
    closed_beta: 'closed_beta',
    released: 'released'
  }

  enum target_type: {
    user: 'user',
    workshop: 'workshop',
    member: 'member'
  }

  def validate_condition
    schema = {
      "type": 'object',
      "properties": {
        "else": {
          "type": 'boolean',
        },
        "if": {
          "type": 'array',
          "items": {
            "type": 'object',
            "properties": {
              "operator": {
                "type": 'string',
                "enum": %w[and or]
              },
              "list": {
                "type": 'array',
                "items": {
                  "type": 'string',
                }
              },
              "value": {
                "type": 'boolean'
              }
            }
          }
        }
      }
    }

    errors.add(:conditions, 'is not valid') unless conditions.present? && JSON::Validator.validate(schema, conditions)
  end
end
