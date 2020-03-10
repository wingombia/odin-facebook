class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @post.comments.create(comment_params)
        responds("Comment Posted");
    end
    def destroy
        comment = Comment.find(params[:id])
        @comments = comment.post.comments;
        comment.delete
        responds("Comment Deleted!");
        
    end
    private
        def comment_params
            param = params.require(:comment).permit(:content)
            param[:user_id] = @post.user.id
            param
        end
        def responds(mesg)
            respond_to do |format|
                format.html do
                    flash[:success] = mesg
                    redirect_to request.referrer
                end
                format.js {flash.now[:success] = mesg}
            end
        end
end
