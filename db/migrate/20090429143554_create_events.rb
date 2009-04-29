class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :uid
      t.string :title
      t.string :location
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
