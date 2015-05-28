class CreateTableOfAssesments < ActiveRecord::Migration
  def change
    create_table :table_of_assesments do |t|
      t.references :owner, index: true
      t.references :photo, index: true
      t.integer :rate

      t.timestamps null: false
    end
    add_foreign_key :table_of_assesments, :owners
    add_foreign_key :table_of_assesments, :photos
  end
end
