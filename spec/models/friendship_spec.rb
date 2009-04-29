require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Friendship do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :friend_id => 1,
      :kind => "value for kind"
    }
  end

  it "should create a new instance given valid attributes" do
    Friendship.create!(@valid_attributes)
  end
end
