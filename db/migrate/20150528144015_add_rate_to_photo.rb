class AddRateToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :rate, :integer
  end
end
