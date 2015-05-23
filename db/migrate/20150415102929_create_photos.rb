class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :album, index: true
      t.string :title, limit: 40
      t.date :creation_date
      t.string :description, limit: 200
      t.integer :num_of_assessments
      t.integer :sum_of_assessments
      t.float :average_rating

      t.timestamps null: false
    end
    add_foreign_key :photos, :albums
  end
end
