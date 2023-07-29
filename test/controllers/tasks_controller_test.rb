require "test_helper"

class TasksControllerTest<ActionDispatch::IntegrationTest
    setup do
        @category1 = categories(:one)
        @category2 = categories(:two)
        @user1 = users(:one)
        @user2 = users(:two)
    end

    test "should not access task with invalid token" do
        post '/users/id/tasks', 
        params: {
            tasks:{
                name: "Task 1",
                due_date: Time.now + 2.days,
                category_id: @category1.id
            }
        },
        headers: { 'Authorization' => "Token 1232"}
        assert_response 401
    end

    test "should create task category insde user" do
        assert_difference('Task.count', 1) do
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
        assert_no_difference('Task.count') do
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

    test "should delete task" do
        user = @user1
        task_id = user.tasks.first.id
        assert_difference('Task.count', -1) do
            delete "/users/id/tasks/#{task_id}", 
            headers: { 'Authorization' => "Token #{user.token}"}
        end
    end

    test "should not delete task not under user" do
        task_id = @user1.tasks.first.id
        assert_no_difference('Task.count') do
            delete "/users/id/tasks/#{task_id}", 
            headers: { 'Authorization' => "Token #{@user2.token}"}
        end
    end

    test "should update task name" do
        task = @user1.tasks.first
        prev_task_name = task.name
        assert_no_difference('Task.count') do
            patch "/users/id/tasks/#{task.id}",
            params:{
                tasks:{
                    name: "updated task",
                    category_id: @category1.id,
                    due_date: Time.now + 3.days
                }
            },
            headers: { 'Authorization' => "Token #{@user1.token}"}
            assert_response :success
        end
        assert_not_equal(prev_task_name, @user1.tasks.first.name)
    end
end