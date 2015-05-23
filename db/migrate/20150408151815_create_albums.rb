class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :owner, index: true
      t.string :name, null: false, unique: true, limit: 120
      t.date :creation_date

      t.timestamps null: false
    end
    add_foreign_key :albums, :owners
  end
end
