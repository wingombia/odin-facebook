class ApiUsersController < ApiController

    before_action :authenticate_user!, except: [:show_profile]
    def show
    end
    def update
        if current_user.update_attributes(user_params)

            render :show
        else
            render json: { errors: current_user.errors }, status: unprocessable_entity
        end
    end
    
    def show_profile
        if !@user = User.find_by_email(params[:email])
            render_error_response_friendship({})
        end
    end

    def befriend
        @user = User.find_by_email(params[:email])
        if @user && current_user.befriend(@user)
            render :show_profile
        else
            error_hash = { errors: current_user.friendships.last.errors }
            render_error_response_friendship(error_hash)
        end
    end

    def unfriend
        @user = User.find_by_email(params[:email])
        if @user && current_user.unfriend(@user)
            render :show_profile
        else
            error_hash = { errors: { friendship: ["not exist"] } }
            render_error_response_friendship(error_hash)
        end
    end

    private
        def user_params
            params.require(:user).permit(:email, :password, :username, :remote_picture_url)
        end

        def render_error_response_friendship(error_hash)
            if !@user
                error_hash = { errors: { user: ["#{params[:email]} can't be found"] } }
            end
            render json: error_hash , status: :unprocessable_entity
        end
end
