class UserUsergroup < ActiveRecord::Base
  belongs_to :usergroup
  belongs_to :user, class_name: 'Owner'

  validates :description, length: {maximum: 100}
  validates :user_id, presence: true
  validates :usergroup_id, presence: true
  validates_uniqueness_of :user_id, scope: [:usergroup]

  before_validation :check_date

  def check_date
    if !self.begin_date.blank?
      self.errors[:begin_date]<<" не существует!" if self.begin_date > Time.now
    end
  end
end