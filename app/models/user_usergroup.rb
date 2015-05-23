class UserUsergroup < ActiveRecord::Base
  belongs_to :usergroup
  belongs_to :owner

  validates :description, length: 100
end