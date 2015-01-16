require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "should create friendship works without raising and exception" do
    assert_nothing_raised do
      UserFriendship.create user: users(:prabhakar), friend: users(:mark)
    end
  end

  test "creating friendship with user_id and friend_id works" do
    UserFriendship.create user_id: users(:prabhakar).id , friend_id: users(:steve).id
    assert users(:prabhakar).friends.include?(users(:steve)) 
  end
end
