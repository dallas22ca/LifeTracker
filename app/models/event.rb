class Event < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  
  accepts_nested_attributes_for :ratings, reject_if: proc { |r| r["content"].blank? }
  
  default_scope -> { order("date desc") }
end
