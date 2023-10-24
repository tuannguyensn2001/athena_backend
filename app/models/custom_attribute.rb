class CustomAttribute < ApplicationRecord
  validates :name, presence: true
  validates :visible, inclusion: { in: [true, false] }

  enum target_type: {
    user: 'user',
    workshop: 'workshop'
  }

  enum data_type: {
    string: 'string',
    integer: 'integer',
    boolean: 'boolean'
  }
end
