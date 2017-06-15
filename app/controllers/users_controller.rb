class UsersController < ApplicationController
  layout "login", only: [:signup, :do_signup]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
#  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
    @users = User.all
    render layout: "admin"
  end

  def signup
    @user = User.new
  end

  def do_signup
    @user = User.new(user_signup_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "signup"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email = @user.username
    @user.name = @user.firstname + ' ' + @user.lastname
    @user.activated = true
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      if @user != nil
        format.json { render json: @user, status: :ok, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    #    debugger
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to users_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def profile
    @activities = UserActivity
                    .select('user_activities.*, u1.name, u1.image, u2.name as user_name_affected, books.title, u3.name as user_name_status, u3.id as user_id_status, u3.image as user_image_status, content, s.image as status_image, location')
                    .joins('LEFT OUTER JOIN users u1 on user_activities.user_id = u1."id"')
                    .joins('LEFT OUTER JOIN books on user_activities.book_affected = books."id"')
                    .joins('LEFT OUTER JOIN users u2 on user_activities.user_affected = u2."id"')
                    .joins('LEFT OUTER JOIN statuses s on user_activities.status_id = s."id"')
                    .joins('LEFT OUTER JOIN users u3 on s.user_id = u3.id')
                    .where('user_activities.user_id = ?', current_user.id)
                    .order('user_activities.created_at DESC')
    @user  = User.find(params[:id])
    @following = @user.following
    @followers = @user.followers
    @favorite_books = Book
                        .joins('INNER JOIN user_books ub on books."id" = ub.book_id')
                        .where('user_id = ? and "isFavorite" = true', params[:id])
    return @activities, @following, @followers, @user, @favorite_books
  end

  def user_list
    @users = User.all.order('created_at DESC').paginate(page: params[:page], per_page: 8)
    @user  = User.find(current_user.id)
    @following = @user.following
    @followers = @user.followers
    return @users, @following, @followers
  end

  private

    def user_signup_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :username, :firstname, :lastname, :address,
                                   :numberphone, :admin)
    end

    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
