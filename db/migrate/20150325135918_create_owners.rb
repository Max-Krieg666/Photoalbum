class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :login, null: false, limit: 24, unique: true
      t.string :password_digest
      t.string :residence
      t.string :sex
      t.date :birthday
      t.string :mail, null: false, unique: true
      t.string :page_link
      t.integer :role

      t.timestamps null: false
    end
  end
end
