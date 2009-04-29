class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :friend
      t.string :kind

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
