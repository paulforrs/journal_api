require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

    test "should create user" do
        assert_difference('User.count',1) do
            post "/users",
            params:{
                user:{
                    email: "users@gmail.com",
                    password: '123123Aa',
                    password_confirmation: "123123Aa"
                }
            }
        end
    end
end
