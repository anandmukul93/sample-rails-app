class UsersController < ApplicationController
	before_action :logged_in_user, only:[:index, :edit, :update, :destroy]
	before_action :correct_user, only:[:edit, :update]
	before_action :admin_user, only: :destroy

	def new
		@user = User.new
	end

	def index
		@users = User.all.paginate(page: params[:page])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Welcome inside my world!"
			log_in @user
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end


	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if (@user.update_attributes(user_params))
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end


	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def logged_in_user
		#to solve that non-logged-in user cannot access the safe pages
		unless logged_in?
			store_location
			flash[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	def correct_user
		@user = User.find(params[:id])
		redirection_path = current_user || index_path
		redirect_to redirection_path unless current_user? @user
	end

	def admin_user
		@user = User.find(params[:id])
		flash[:danger] = 'You need to have admin rights' unless current_user.admin?
		flash[:danger] = 'You cannot delete yourself' if current_user.admin? && current_user?(@user)
		redirect_to users_url unless current_user.admin? && !current_user?(@user)
	end

end