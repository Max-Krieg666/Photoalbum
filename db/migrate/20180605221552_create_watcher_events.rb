class CreateWatcherEvents < ActiveRecord::Migration
  def change
    create_table :watcher_events do |t|
      t.string :title,  null: false
      t.string :status, default: 'Success'
      t.string :kind
      t.text   :description
      t.text   :data
      t.string :user_login
      t.string :user_ip

      t.timestamps null: false
    end
  end
end
