class Ticket < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :status, presence: true, inclusion: { in: %w[open in_progress resolved closed] }
  validates :priority, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :user_id, presence: true
  
  # Set default values
  after_initialize :set_defaults, if: :new_record?
  
  private
  
  def set_defaults
    self.status ||= 'open'
    self.priority ||= 1
  end
end
