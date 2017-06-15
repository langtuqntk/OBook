require 'test_helper'

class RatingBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating_book = rating_books(:one)
  end

  test "should get index" do
    get rating_books_url
    assert_response :success
  end

  test "should get new" do
    get new_rating_book_url
    assert_response :success
  end

  test "should create rating_book" do
    assert_difference('RatingBook.count') do
      post rating_books_url, params: { rating_book: { rating: @rating_book.rating } }
    end

    assert_redirected_to rating_book_url(RatingBook.last)
  end

  test "should show rating_book" do
    get rating_book_url(@rating_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_rating_book_url(@rating_book)
    assert_response :success
  end

  test "should update rating_book" do
    patch rating_book_url(@rating_book), params: { rating_book: { rating: @rating_book.rating } }
    assert_redirected_to rating_book_url(@rating_book)
  end

  test "should destroy rating_book" do
    assert_difference('RatingBook.count', -1) do
      delete rating_book_url(@rating_book)
    end

    assert_redirected_to rating_books_url
  end
end
