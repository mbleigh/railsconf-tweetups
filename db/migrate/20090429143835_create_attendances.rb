class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.timestamps
    end
  end

  def self.down
    drop_table :attendances
  end
end
