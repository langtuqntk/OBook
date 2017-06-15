class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:timeline]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # trang homepage giao dien nguoi dung
  def timeline
    @activities = UserActivity
                    .select('user_activities.*, u1.name, u1.image, u2.name as user_name_affected, u2.id as user_id_affected, books.title, u3.name as user_name_status, u3.id as user_id_status, u3.image as user_image_status, content, s.image as status_image, location, amountlike')
                    .joins('LEFT OUTER JOIN users u1 on user_activities.user_id = u1."id"')
                    .joins('LEFT OUTER JOIN books on user_activities.book_affected = books."id"')
                    .joins('LEFT OUTER JOIN users u2 on user_activities.user_affected = u2."id"')
                    .joins('LEFT OUTER JOIN statuses s on user_activities.status_id = s."id"')
                    .joins('LEFT OUTER JOIN users u3 on s.user_id = u3.id')
                    .joins('LEFT OUTER JOIN (select COUNT(*) as amountlike, user_activity_id from like_activities group by user_activity_id) la on user_activities.id = la.user_activity_id')
                    .order('user_activities.created_at DESC')
    like_activities = LikeActivity.where('user_id = ?', current_user.id)
    @likeArrOfCurrentUser = Array.new
    @activities.each_with_index do |activity, i|
      like_activities.each do |like_activity|
        if activity.id == like_activity.user_activity_id
          @likeArrOfCurrentUser.push(i)
        end
      end
    end
    return @activities, @likeArrOfCurrentUser
  end

  def like_activity
    @like_activity = LikeActivity.new(:user_id => current_user.id, :user_activity_id => params[:id], islike: true)
    respond_to do |format|
      if @like_activity.save
        format.json { render json: @like_activity, status: :created, location: @like_activity }
      else
        format.json { render json: @like_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def unlike_activity
    @like_activity = LikeActivity
                      .where('user_id = ? and user_activity_id = ?', current_user.id, params[:id])
    respond_to do |format|
      if @like_activity != nil
        @like_activity.destroy_all
        format.json { head :no_content }
      else
        format.json { render json: @like_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:type)
    end
end
