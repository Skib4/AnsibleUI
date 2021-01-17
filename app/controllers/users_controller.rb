class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def index
#   @users = User.all
if params[:approved] == "false"
  flash[:danger] = "User not approved!"
  @users = User.where(approved: false)
else
  @users = User.page(params[:page]).per(10)
end
  end

  def show
   @user = User.find(params[:id])
  end

  def new
   @user = User.new
  end

  def edit
   @user = User.find(params[:id])
  end

  def create
   @user = User.new(user_params)

   if @user.save
     flash[:notice] = "User was successfully created!"
     redirect_to users_path
   else
     render :action => 'new'
   end
 end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update_attributes(user_params)
      flash[:notice] = "User was successfully updated!"
      redirect_to users_path
    else
      render :action => 'edit'
    end
  end

  def confirm_destroy
    @user = User.find(params[:id])
    if @user.id == 1
      flash[:danger] = "You are not allowed to delete main admin!"
      redirect_to users_path
    end
  end

  def destroy
   @user = User.find(params[:id])
   @user.destroy
   flash[:notice] = "User was successfully deleted."
   redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname, :approved, :admin, :host_id )
  end

  def is_admin
    if current_user.admin == false
      flash[:danger] = "You are not allowed to see this page!"
      redirect_to root_path
    end
  end

  def active_for_authentication?
  super && approved?
end

def inactive_message
  approved? ? super : :not_approved
end

end
