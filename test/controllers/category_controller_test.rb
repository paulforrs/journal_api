require "test_helper"

class CategoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "index tasks" do
    get "users/id/categories", as: :json, headers: {:Authorization => "Token "+ @user.token}
    assert_response :success
  end
end
