class AddOwnerToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :owner, index: true
    add_foreign_key :comments, :owners
  end
end
