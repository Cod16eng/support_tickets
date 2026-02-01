class UsersController < ApplicationController
    before_action :authorize
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to @user, notice: 'User was successfully created.'
        else
            render :new
        end
    end

    def edit
        unless @user.id == current_user.id
            redirect_to users_path, alert: 'You can only edit your own profile.'
        end
    end

    def update
        unless @user.id == current_user.id
            redirect_to users_path, alert: 'You can only update your own profile.'
            return
        end
        
        if @user.update(user_params)
            redirect_to @user, notice: 'User was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        unless @user.id == current_user.id
            redirect_to users_path, alert: 'You can only delete your own account.'
            return
        end
        
        @user.destroy
        redirect_to users_url, notice: 'User was successfully destroyed.'
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :username, :password, :password_confirmation, :role)
    end
end