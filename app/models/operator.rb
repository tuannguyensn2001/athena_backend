class Operator
  STRING = [
    {
      name: 'Equal',
      value: 'eq',
      input: true
    },
    {
      name: 'Not Equal',
      value: 'ne',
      input: true
    }
  ].freeze

  INTEGER = [
    {
      name: 'Equal',
      value: 'eq',
      input: true
    },
    {
      name: 'Not Equal',
      value: 'ne',
      input: true
    },
    {
      name: 'Greater Than',
      value: 'gt',
      input: true
    },
    {
      name: 'Less Than',
      value: 'lt',
      input: true
    }
  ].freeze

  BOOLEAN = [
    {
      name: 'True',
      value: 'true'
    },
    {
      name: 'False',
      value: 'false'
    }
  ].freeze

  TARGET_GROUP = [
    {
      name: 'All of the conditions match',
      value: 'and'
    },
    {
      name: 'Any of the conditions match',
      value: 'or'
    }
  ].freeze

  def self.get_operator(type)
    case type
    when 'string'
      STRING
    when 'integer'
      INTEGER
    when 'boolean'
      BOOLEAN
    when 'target_group'
      TARGET_GROUP
    else
      []
    end
  end
end
