class FriendshipsController < ApplicationController
    def create
        @pending = params[:pending]
        @user = User.find(params[:user_id])
        if @pending
            current_user.befriend(@user)
        else
            current_user.accept_request(@user)
        end 
        respond_to do |format|
            format.html { redirect_to users_path }
            format.js
        end
    end
    def destroy
        @user = User.find(params[:user_id])
        current_user.unfriend(@user)
        respond_to do |format|
            format.html { rendirect_to users_path }
            format.js
        end
    end
end
