class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def book_list
    @books = Book
              .select('books.*, COUNT(review_books.id) AS "reviews"')
              .left_outer_joins(:review_book)
              .group('books.id')
              .order('books.created_at DESC')
              .paginate(page: params[:page], :per_page => 32)
  end

  def favorite_list
    @books = Book
              .select('books.*,user_books.isfavorite')
              .joins(:user_book)
              .where('user_books.isfavorite = true and user_books.user_id = ?', current_user.id)
              .order('user_books.created_at DESC')
              .paginate(page: params[:page], :per_page => 32)
  end

  def detail_book
    @review_book = ReviewBook.new

    @book = Book
              .select('books.*, COUNT(review_books.id) AS "reviews"')
              .left_outer_joins(:review_book)
              .group('books.id')
              .order('books.id ASC')
              .find(params[:id])
    @reviews = ReviewBook
                .select('review_books.id, review_books.title,review_books.contenthtml,
                          review_books.created_at as "reviewed_at",users.name')
                .joins('INNER JOIN users ON review_books.user_id = users.id')
                .where(:book_id => @book.id)
                .group('review_books.id, users.name')
                .order('review_books.created_at DESC')
    @comments = Comment
                  .select('comments.*,users.name')
                  .joins(:user)
                  .order('comments.created_at DESC')
    return @book, @reviews, @comments, @review_book
  end

  def create_review_book
    url = "/detail_book/#{params[:review_book][:book_id]}"
    @review = ReviewBook.new(review_params)
    @rating = RatingBook.new
    @rating.rating = params[:review][:rating]
    @rating.user_id = params[:review_book][:user_id]
    @rating.book_id = params[:review_book][:book_id]
    if @review.save && @rating.save
      redirect_to url
    else
      redirect_to root_url
    end
  end

  def history_list
    @books = Book
              .select('books.*,user_books.created_at as marked_at, user_books.id as mark_id, user_books.readstatus')
              .joins(:user_book)
              .where('readstatus is not NULL and readstatus != 0 and user_id = ?', current_user.id)
              .order('created_at DESC')
  end

  #load_detail_book in history page
  def load_content_book
    @book = Book.find(params[:id])
    respond_to do |format|
      if @book != nil
        format.json { render json: @book, status: :ok, location: @book }
      else
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def unmark_book
    @book = UserBook.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def book_search
    if params[:category] != nil
      if params[:textsearch] == "" && params[:category] == "0"
        @books = Book.order('created_at DESC').paginate(page: params[:page], :per_page => 8)
      elsif params[:textsearch] != "" && params[:category] == "0"
        @books = Book
                  .where("title LIKE ?", "%#{params[:textsearch]}%")
                  .order('created_at DESC')
                  .paginate(page: params[:page], :per_page => 8)
      else
        @books = Book
                  .joins('INNER JOIN category_books cb on books."id"= cb.book_id')
                  .where("title LIKE ? and category_id = ?", "%#{params[:textsearch]}%", params[:category])
                  .order('created_at DESC')
                  .paginate(page: params[:page], :per_page => 8)
      end
    else
      if params[:textsearch] == ""
        @books = Book.order('created_at DESC').paginate(page: params[:page], :per_page => 8)
      else
        @books = Book
                  .where("title LIKE ?", "%#{params[:textsearch]}%")
                  .order('created_at DESC')
                  .paginate(page: params[:page], :per_page => 8)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      #@book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:bookid, :title, :author, :description, :numberpage)
    end

    def review_params
      params.require(:review_book).permit(:title,:contenthtml,:user_id,:book_id)
    end

end
