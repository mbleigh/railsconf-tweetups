class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validates_uniqueness_of :friend_id, :scope => :user_id
  
  named_scope :followers, :conditions => {:kind => 'Follower'}
  named_scope :following, :conditions => {:kind => 'Following'}
  named_scope :mutual, :conditions => {:kind => 'Mutual'}

  def self.mass_create(kind, user, twitter_ids)
    User.all.each do |friend|
      create(:user => user, :kind => kind, :friend => friend) if twitter_ids.include?(friend.twitter_id.to_i)
    end
  end
end
