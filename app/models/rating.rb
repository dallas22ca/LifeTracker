class Rating < ActiveRecord::Base
  belongs_to :category
  belongs_to :event
  has_one :user, through: :event
  
  validates_uniqueness_of :category_id, scope: :event_id
  
  before_save :integerize
  
  def integerize
    self.quantity = self.content.to_i
  end
end
