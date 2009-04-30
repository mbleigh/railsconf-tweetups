class User < TwitterAuth::GenericUser
  # Extend and define your user model as you see fit.
  # All of the authentication logic is handled by the 
  # parent TwitterAuth::GenericUser class.
  has_many :attendances, :dependent => :destroy
  has_many :events, :through => :attendances
  has_many :friendships
  has_many :friends, :through => :friendships, :source => :friend

  named_scope :in_twitter_ids, lambda{|ids| 
    {:conditions => ids.collect{|id| "users.twitter_id = '#{id}'"}.join(" OR ")}
  }

  named_scope :by_date, :order => "created_at DESC"
  named_scope :limit, lambda{ |l| {:limit => l} }

  def following_ids
    twitter.get('/friends/ids')
  end

  def follower_ids
    twitter.get('/followers/ids')
  end

  def refresh_friendships!
    followers = follower_ids
    following = following_ids

    everyone = followers & following
    friends = followers & following
    followers -= friends
    following -= friends

    self.friendships.destroy_all

    Friendship.mass_create('Mutual', self, friends)
    Friendship.mass_create('Follower', self, followers)
    Friendship.mass_create('Following', self, following)    

    self.update_attributes(:updated_at => Time.now)
    self.friends
  end

  def friends_at(event)
    event.users & self.friends
  end

  def to_param
    login
  end
end
