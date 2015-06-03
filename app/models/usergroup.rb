class Usergroup < ActiveRecord::Base
  has_and_belongs_to_many :owner, join_table: 'usergroups_users'#, class_name: 'Patient'
  has_many :user_usergroups
  has_many :usergroups_accesses

  validates :name, presence: true
end
