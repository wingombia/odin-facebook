class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @user.liked_posts << @post
    respond_to do |format|
      format.json {render(json: {
          data: render_to_string(partial: 'posts/like_stats.html.erb', locals: {post: @post})
        })
      }
      format.html {redirect_to '/posts'}
      
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @user.liked_posts.delete(@post)
    respond_to do |format|
      format.json {render(json: {
          data: render_to_string(partial: 'posts/like_stats.html.erb', locals: {post: @post})
        })
      }
      format.html {redirect_to '/posts'}
      
    end
  end
end
