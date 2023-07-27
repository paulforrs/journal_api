require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  test "should save user" do
    user = User.new
    user.email = "test@gmail.com"
    user.password = '123123aA'
    user.password_confirmation = '123123aA'
    assert user.save
  end

  test "should trigger password validation" do
    user = User.new
    user.email = "test@gmail.com"
    user.password = '123123'
    user.password_confirmation = '123123'
    assert_not user.save
  end


  test "should not save user when email is incorrect format" do
    user = User.new
    user.email = 'tes12323@gmailcomtm'
    user.password = '123123aA'
    user.password_confirmation = '123123aA'
    assert_not user.save
  end

  test "should not save user when password don't match" do
    user = User.new
    user.email = 'tes12323@gmailcomtm'
    user.password = '12312123'
    user.password_confirmation = '123123'
    assert_not user.save
  end

end
