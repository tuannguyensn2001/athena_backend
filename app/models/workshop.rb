class Workshop < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :grade, presence: true
  validates :subject, presence: true

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :posts, dependent: :destroy

  Workshop.columns.each do |column|
    if column.type == :boolean
      define_method "#{column.name}?" do
        self.send(column.name)
      end
    end
  end
end
