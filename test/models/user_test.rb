require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save" do
    user = User.new
    user.email = 'postman@gmail.com'
    user.password = 'postman'
    user.password_confirmation = "postman"
    assert user.save
  end
end
