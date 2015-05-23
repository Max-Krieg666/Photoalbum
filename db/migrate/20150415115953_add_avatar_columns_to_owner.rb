class AddAvatarColumnsToOwner < ActiveRecord::Migration
  def self.up
    change_table :owners do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :owners, :avatar
  end
end
