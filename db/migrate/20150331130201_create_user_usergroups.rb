class CreateUserUsergroups < ActiveRecord::Migration
  def change
    create_table :user_usergroups do |t|
      t.references :usergroup, index: true
      t.references :user, index: true
      t.date :begin_date
      t.string :description

      t.timestamps null: false
    end
    add_foreign_key :user_usergroups, :usergroups
    add_foreign_key :user_usergroups, :users
  end
end
