class Usergroup < ActiveRecord::Base
  belongs_to :owner
  has_many :user_usergroups

  validates :name, presence: true
end
