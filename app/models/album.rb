class Album < ActiveRecord::Base
  belongs_to :owner
  has_many :photos

  validates :name, presence: true, uniqueness: true, length: {maximum: 120}
end
