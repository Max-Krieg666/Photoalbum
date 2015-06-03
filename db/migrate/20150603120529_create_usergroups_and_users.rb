class CreateUsergroupsAndUsers < ActiveRecord::Migration
  def change
    create_table :usergroups_users, id: false do |t|
      t.belongs_to :usergroup, index: true
      t.belongs_to :user, index: true, class_name: 'Owner'
    end
    add_index :usergroups_users, [:usergroup_id, :user_id], unique: true
  end
end
