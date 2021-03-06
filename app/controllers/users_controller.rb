class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only:[:edit, :update]
  before_filter :admin_user, only: :destroy

	def show
		@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

	end
  	
  def new
  	@user = User.new
    unless !signed_in?
      flash[:notice] = "Already signed in"
      redirect_to root_path
    end
  end

	def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user]) #I guess this changes the object in the data table for you
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
    unless signed_in?
      store_location
      flash[:notice] = "Please sign in"
      redirect_to signin_url
    end
  end

  def destroy
    if current_user?(User.find(params[:id]))
      flash[:error] = "Admin cannot destroy self"
      redirect_to user_path(current_user)
    else
      destroyed_user_name = User.find(params[:id]).name
      flash[:success] = "#{destroyed_user_name} destroyed"
      User.find(params[:id]).destroy
      redirect_to users_url
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:error] = "Must be signed as the user to edit"
        redirect_to root_path
      end
    end

    def admin_user
      unless current_user.admin?
        flash[:error] = "Must be an admin user to destroy"
        redirect_to root_path
      end
    end

end
