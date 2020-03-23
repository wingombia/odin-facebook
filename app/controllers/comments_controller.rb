class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @post.comments.create(comment_params)
        @comments = @post.comments;
        responds("Comment posted!");
    end
    def destroy
        comment = Comment.find(params[:id])
        @comments = comment.post.comments;
        comment.delete
        responds("Comment deleted!");
    end

    def render_comments
        @post = Post.find(params[:post_id])
        
    end
    
    private
        def comment_params
            param = params.require(:comment).permit(:content)
            param[:user_id] = current_user.id
            param
        end
        def responds(mesg)
            #flash.now[:success] = mesg;
            render json: {
                comments: render_to_string(@comments)
                #flash: render_to_string(partial: 'layouts/flash.html.erb')
            }
        end
end
