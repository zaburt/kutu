require 'test_helper'

class ArticleCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_category = article_categories(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get article_categories_path
    assert_response :success
  end

  test "should get new" do
    get new_article_category_path
    assert_response :success
  end

  test "should create article_category" do
    assert_difference('ArticleCategory.count') do
      post article_categories_path, params: { article_category: { name: @article_category.name } }
    end

    assert_redirected_to article_category_path(ArticleCategory.last)
  end

  test "should show article_category" do
    get article_category_path(@article_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_category_path(@article_category)
    assert_response :success
  end

  test "should update article_category" do
    patch article_category_path(@article_category), params: { article_category: { name: @article_category.name } }
    assert_redirected_to article_category_path(@article_category)
  end

  test "should destroy article_category" do
    assert_difference('ArticleCategory.count', -1) do
      delete article_category_path(@article_category)
    end

    assert_redirected_to article_categories_path
  end
end
