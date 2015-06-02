class Album < ActiveRecord::Base
  belongs_to :owner
  has_many :photos

  validates :name, presence: true, uniqueness: true, length: {maximum: 120}
  before_validation :check_date

  def check_date
    self.errors[:creation_date]<<" не существует!" if self.creation_date > Time.now
  end
end
