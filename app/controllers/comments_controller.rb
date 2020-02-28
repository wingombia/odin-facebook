class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @post.comments.create(comment_params)
        redirect_to post_path(@post)
    end
    def destroy
        comment = Comment.find(params[:id])
        comment.delete
        flash[:success] = "Comment deleted!"
        redirect_to post_path(Post.find(params[:post_id]))
    end
    private
     def comment_params
        param = params.require(:comment).permit(:content)
        param[:user_id] = @post.user.id
        param
     end
end
