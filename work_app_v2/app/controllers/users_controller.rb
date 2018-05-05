class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user, only: [:edit, :update]

    def index
      redirect_to signup_url
    end

  	def show
  		@user = User.find(params[:id])
      @microposts = Micropost.all
      @feed_items = current_user.feed.paginate(page: params[:page])
  	end

  	def new
  		@user = User.new
  	end

  	def create
  		@user = User.new(user_params)
  		if @user.save
        log_in @user
  			flash[:success] = "Welcome! You have signed up successfully."
  			redirect_to root_url
  		else
  			render 'new'
  		end
  	end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Your account has been updated successfully"
        redirect_to root_url
      else
        render 'edit'
      end
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    #перенаправть на главную если пользователь 
    #попытаеться поменять профиль другого пользователя
    def correct_user 
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

  	private
  		def user_params
  			params.require(:user).permit(:name, :email, :phone, :surname, :password, :password_confirmation)
  		end
end
