class PostsController < ApplicationController
    before_action :authenticate_user!
    def index
        @posts = current_user.get_timeline.paginate(page: params[:page])
        @post_new = current_user.posts.build
    end
    def show
        @post = current_user.posts.find(params[:id])
        @comment = @post.comments.build
        @comments = @post.comments.paginate(page: params[:page])
        respond_to do |format|
            format.html
            format.js
        end
    end
    def create
        post = current_user.posts.build(post_params)
        if post.save
            flash[:success] = "Saved post successfully!"
            redirect_to root_url
        else
            render 'index'
        end
    end
    def destroy
        post = Post.find(params[:id])
        post.delete
        flash[:success] = "Post deleted!"
        redirect_to root_url
    end
    private
        def post_params
            params.require(:post).permit(:content)
        end
end
