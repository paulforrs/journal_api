require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @category = categories(:one)
  end

  test "should not access if token not found" do
    get "/users/id/categories",
      headers: { 'Authorization' => "Token asdasd123"}
    assert_response 401
  end

  test "should index categories" do
    get "/users/id/categories",
      headers: { 'Authorization' => "Token #{@user1.token}"}
    assert_response :success, "Shows category index"
  end

  test "should show categories" do
    get "/users/id/categories/1",
      headers: { 'Authorization' => "Token #{@user1.token}"}
    assert_response :success
  end

  test "should create new category" do
    assert_difference('@user1.categories.count',1) do
      post "/users/id/categories",
      params: {
        categories: { name: "Category"}
      },
      headers: { 'Authorization' => "Token #{@user1.token}"}
    end
  end

  test "should destroy category" do
    @id = @user1.categories.last.id
    assert_difference('Category.count', -1) do
      delete "/users/id/categories/#{@id}",
      headers: { 'Authorization' => "Token #{@user1.token}"}
    end
  end

  test "should destroy tasks under category" do
    @id = @user1.categories.last.id
    assert_difference('Task.count', -(@user1.categories.find_by_id(@id)).tasks.length) do
      delete "/users/id/categories/#{@id}",
      headers: { 'Authorization' => "Token #{@user1.token}"}
    end
  end

  test "should not destroy category not belonging to user" do
    @id = @user2.categories.last.id
    assert_no_difference('Category.count') do
      delete "/users/id/categories/#{@id}",
      headers: { 'Authorization' => "Token #{@user1.token}"}
    end
  end

  test "should update user category" do
    prevCategoryName = @user1.categories.first.name
    id = @user1.categories.first.id
    assert_no_difference('@user1.categories.count') do
      patch "/users/id/categories/#{id}",
      params: {
        categories: { name: 'Updated'}
      },
      headers: { 'Authorization' => "Token #{@user1.token}"}
    end
    assert_not_equal(prevCategoryName, @user1.categories.first.name)
  end


  test "should not update category not belonging to user" do
    prevCategoryName = @user2.categories.first.name
    id = @user2.categories.first.id
    assert_no_difference('@user1.categories.count') do
      patch "/users/id/categories/#{id}",
      params: {
        categories: { name: 'Test0001'}
      },
      headers: { 'Authorization' => "Token #{@user1.token}"}
    end
    assert_equal(prevCategoryName, @user2.categories.first.name)
  end

  
end
