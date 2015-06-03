class CreateUsergroupsAccesses < ActiveRecord::Migration
  def change
    create_table :usergroups_accesses do |t|
      t.references :photo, index: true
      t.references :usergroup, index: true
      t.boolean :access

      t.timestamps null: false
    end
    add_foreign_key :usergroups_accesses, :photos
    add_foreign_key :usergroups_accesses, :usergroups
  end
end
