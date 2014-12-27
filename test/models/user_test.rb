require 'test_helper'

class UserTest < ActiveSupport::TestCase

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

  # test "users proile name must be formatted correctly" do
  #   user = User.new(first_name: "jason", last_name: "seifer", email: "jason@gmail.com")
  #   user.password = user.password_confirmation = "abcdefg"
  #   user.profile_name = "jasonseifer_1"
  #   assert user.valid?
  # end
end
