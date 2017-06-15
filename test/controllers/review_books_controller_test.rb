require 'test_helper'

class ReviewBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review_book = review_books(:one)
  end

  test "should get index" do
    get review_books_url
    assert_response :success
  end

  test "should get new" do
    get new_review_book_url
    assert_response :success
  end

  test "should create review_book" do
    assert_difference('ReviewBook.count') do
      post review_books_url, params: { review_book: { contenthtml: @review_book.contenthtml, title: @review_book.title } }
    end

    assert_redirected_to review_book_url(ReviewBook.last)
  end

  test "should show review_book" do
    get review_book_url(@review_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_review_book_url(@review_book)
    assert_response :success
  end

  test "should update review_book" do
    patch review_book_url(@review_book), params: { review_book: { contenthtml: @review_book.contenthtml, title: @review_book.title } }
    assert_redirected_to review_book_url(@review_book)
  end

  test "should destroy review_book" do
    assert_difference('ReviewBook.count', -1) do
      delete review_book_url(@review_book)
    end

    assert_redirected_to review_books_url
  end
end
