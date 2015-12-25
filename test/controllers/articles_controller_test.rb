require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post :create, article: { content: @article.content, created_by: @article.created_by, game_id: @article.game_id, picture_id: @article.picture_id, publish: @article.publish, publish_time: @article.publish_time, title: @article.title, updated_by: @article.updated_by }
    end

    assert_redirected_to article_path(assigns(:article))
  end

  test "should show article" do
    get :show, id: @article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article
    assert_response :success
  end

  test "should update article" do
    patch :update, id: @article, article: { content: @article.content, created_by: @article.created_by, game_id: @article.game_id, picture_id: @article.picture_id, publish: @article.publish, publish_time: @article.publish_time, title: @article.title, updated_by: @article.updated_by }
    assert_redirected_to article_path(assigns(:article))
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
  end
end
