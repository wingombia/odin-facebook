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
            format.json { render(json: {
                data: current_user.get_friend_status(@user)
                })
            }
        end
    end
    def destroy
        @user = User.find(params[:user_id])
        current_user.unfriend(@user)
        respond_to do |format|
            format.html { redirect_to users_path }
            format.json { render(json: {
                data: current_user.get_friend_status(@user)
                })
            }
        end
    end
end
