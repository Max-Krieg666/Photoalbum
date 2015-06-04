class UserUsergroup < ActiveRecord::Base
  belongs_to :usergroup
  belongs_to :user, class_name: 'Owner'

  validates :description, length: {maximum: 100}
  validates :user_id, presence: true
  validates :usergroup_id, presence: true
  validates_uniqueness_of :user_id, scope: :usergroup_id

  before_validation :check_date, :check_user

  def check_date
    if !self.begin_date.blank?
      self.errors[:begin_date]<<" не существует!" if self.begin_date > Time.now
    end
  end

  def check_user
    self.errors[:user_id]<<": нельзя добавить самого себя!" if self.user_id == self.usergroup.owner_id
  end
end
