require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest

    test "should create new user" do
        assert_difference("User.count",1) do
            post "/auth/signup",
            params: {
                user: {
                    email: "test@gmail.com",
                    password: "12345678aA",
                    password_confirmation: "12345678aA"
                }
            }, as: :json
        end
    end

    # test "should signin" do
    #     post "/auth/signin",
    #     params: {
    #         user: {
    #             email: "test@gmail.com",
    #             password: "12345678aA",
    #         }
    #     }, as: :json
    #     assert_response :success
    # end

end