require 'test_helper'

class CategoryBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_book = category_books(:one)
  end

  test "should get index" do
    get category_books_url
    assert_response :success
  end

  test "should get new" do
    get new_category_book_url
    assert_response :success
  end

  test "should create category_book" do
    assert_difference('CategoryBook.count') do
      post category_books_url, params: { category_book: {  } }
    end

    assert_redirected_to category_book_url(CategoryBook.last)
  end

  test "should show category_book" do
    get category_book_url(@category_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_book_url(@category_book)
    assert_response :success
  end

  test "should update category_book" do
    patch category_book_url(@category_book), params: { category_book: {  } }
    assert_redirected_to category_book_url(@category_book)
  end

  test "should destroy category_book" do
    assert_difference('CategoryBook.count', -1) do
      delete category_book_url(@category_book)
    end

    assert_redirected_to category_books_url
  end
end
