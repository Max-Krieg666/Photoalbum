class CreateUsergroups < ActiveRecord::Migration
  def change
    create_table :usergroups do |t|
      t.string :name
      t.references :owner, index: true

      t.timestamps null: false
    end
    add_foreign_key :usergroups, :owners
  end
end