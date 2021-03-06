require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password")
    sign_in_as(@user)
  end

  test "get new article form and create new article" do
    get "/articles/new"
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "test article", description: "test description of test article" }}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Article was created successfully", response.body
  end

end
