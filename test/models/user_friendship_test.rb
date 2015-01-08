require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "should create friendship works without raising and exception" do
    assert_nothing_raised do
      UserFriendship.create user: users(:prabhakar), friend: users(:mark)
    end
  end
end
