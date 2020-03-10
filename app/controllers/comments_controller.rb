class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @post.comments.create(comment_params)
        redirect_to post_path(@post)
    end
    def destroy
        comment = Comment.find(params[:id])
        @comments = comment.post.comments;
        comment.delete
       
        respond_to do |format|
            format.html do
                flash[:success] = "Comment Deleted!"
                redirect_to request.refferer 
            end
            format.js {flash.now[:success] = "Comment Deleted!"}
        end
    end
    private
     def comment_params
        param = params.require(:comment).permit(:content)
        param[:user_id] = @post.user.id
        param
     end
end
