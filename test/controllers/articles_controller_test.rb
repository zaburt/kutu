require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get articles_path
    assert_response :success
  end

  test "should get new" do
    get new_article_path
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_path, params: { article: { content: @article.content, created_by_id: @article.created_by_id, game_id: @article.game_id, picture_id: @article.picture_id, publish: @article.publish, publish_time: @article.publish_time, title: @article.title, updated_by_id: @article.updated_by_id } }
    end

    assert_redirected_to article_path(Article.last)
  end

  test "should show article" do
    get article_path(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_path(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_path(@article), params: { article: { content: @article.content, created_by_id: @article.created_by_id, game_id: @article.game_id, picture_id: @article.picture_id, publish: @article.publish, publish_time: @article.publish_time, title: @article.title, updated_by_id: @article.updated_by_id } }
    assert_redirected_to article_path(@article.reload)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_path(@article)
    end

    assert_redirected_to articles_path
  end
end
