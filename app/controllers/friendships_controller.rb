class FriendshipsController < ApplicationController
    def create
        @pending = params[:pending]
        @user = User.find(params[:user_id])
        if @pending
            current_user.friendships.create(friend_id: @user.id, pending: true)
        else
            @friendship = current_user.inverse_friendships.find_by(user_id: @user.id)
            @friendship.pending = false
            @friendship.save
            
        end 
        respond_to do |format|
            format.html { redirect_to users_path }
            format.js
        end
    end
    def destroy
        @user = User.find(params[:user_id])
        current_user.friend?(@user).delete
        respond_to do |format|
            format.html { rendirect_to users_path }
            format.js
        end
    end
end
