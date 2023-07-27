require "test_helper"

class TasksControllerTest<ActionDispatch::IntegrationTest
    setup do
        @category1 = categories(:one)
        @category2 = categories(:two)
        @user1 = users(:one)
        @user2 = users(:two)
    end

    test "should create task category insde user" do
        assert_difference('@user1.tasks.count', 1) do
            post '/users/id/tasks', 
            params: {
                tasks:{
                    name: "Task 1",
                    due_date: Time.now + 2.days,
                    category_id: @category1.id
                }
            },
            headers: { 'Authorization' => "Token #{@user1.token}"}
        end
    end

    test "should not create task for category outside user" do
        assert_difference('Task.count', 0) do
            post '/users/id/tasks', 
            params: {
                tasks:{
                    name: "Task 1",
                    due_date: Time.now + 2.days,
                    category_id: @category2.id
                }
            },
            headers: { 'Authorization' => "Token #{@user1.token}"}
        end
    end

    # test "should create task" do
    #     task = @user1.tasks.new
    #     task.name = "pauls"
    #     task.category_id = 1
    #     task.due_date = Time.now
    #     assert task.save
    # end

end