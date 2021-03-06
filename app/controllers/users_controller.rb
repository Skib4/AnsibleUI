class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def index
     if params[:approved] == "false"
 	 flash[:danger] = "Użytkownik jest nieuprawniony!"
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
     flash[:notice] = "Utworzono użytkownika!"
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
      flash[:notice] = "Edytowano użytkownika!"
      redirect_to users_path
    else
      render :action => 'edit'
    end
  end

  def confirm_destroy
    @user = User.find(params[:id])
    if @user.id == 1
      flash[:danger] = "Nie można usunąć głównego administratora!"
      redirect_to users_path
    end
  end

  def destroy
   @user = User.find(params[:id])
   @user.destroy
   flash[:notice] = "Usunięto użytkownika!"
   redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname, :approved, :admin )
  end

  def is_admin
    if current_user.admin == false
      flash[:danger] = "Użytkownik nieuprawniony!"
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
