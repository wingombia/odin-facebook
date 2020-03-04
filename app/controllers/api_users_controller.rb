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
        @user = User.find_by_email(params[:email])
    end

    private
        def user_params
            params.require(:user).permit(:email, :password, :username, :remote_picture_url)
        end
end
