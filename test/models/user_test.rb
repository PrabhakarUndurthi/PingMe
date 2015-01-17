require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter their first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "user should enter last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "user should enter profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "user should enter uniq profile name" do
    user = User.new
    user.profile_name = "PrabhakarUndurthi"
    user.first_name   = "Prabhakar"
    user.last_name    = "Undurthi"
    user.email        = "prabhakar@railsmancer.com"
    user.password     = "password"
    user.password_confirmation = "password"
    assert !user.save

    puts user.errors.inspect

    assert !user.errors[:profile_name].empty?
  end

  test "profile name should have profile name without spaces" do
    user = User.new
    user.profile_name = "Profile Name with spaces"
    assert !user.save
    assert user.errors[:profile_name].include?("Must be formatted correctly")
  end

  test "users proile name must be formatted correctly" do
    user = User.new(first_name: "prabhakar", last_name: "u", email: "prabhakar@gmail.com")
    user.password = user.password_confirmation = "abcdefg"
    user.profile_name = "jseifer"
    assert user.valid?
  end

  test "it should not raise any exception while accessing the friends list" do
    assert_nothing_raised  do
      users(:prabhakar).friends
    end
  end

  test "creating friendship works" do
    users(:prabhakar).friends << users(:steve)
    users(:prabhakar).friends.reload
    users(:prabhakar).friends.include?(users(:steve))
  end

  test "calling to_param on a profile_name should return the profle" do
    assert_equal "hsteve", users(:steve).to_param
  end
end
