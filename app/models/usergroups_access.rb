class UsergroupsAccess < ActiveRecord::Base
  belongs_to :photo
  belongs_to :usergroup

  validates_uniqueness_of :usergroup_id, scope: :photo_id, message:": для выбранной группы настройки уже существуют!"
end
