require 'test_helper'

class ArticleCategoriesControllerTest < ActionController::TestCase
  setup do
    @article_category = article_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_category" do
    assert_difference('ArticleCategory.count') do
      post :create, article_category: { name: @article_category.name }
    end

    assert_redirected_to article_category_path(assigns(:article_category))
  end

  test "should show article_category" do
    get :show, id: @article_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_category
    assert_response :success
  end

  test "should update article_category" do
    patch :update, id: @article_category, article_category: { name: @article_category.name }
    assert_redirected_to article_category_path(assigns(:article_category))
  end

  test "should destroy article_category" do
    assert_difference('ArticleCategory.count', -1) do
      delete :destroy, id: @article_category
    end

    assert_redirected_to article_categories_path
  end
end
