class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @user.liked_posts << @post
    respond_to do |format|
      format.html {render @post}
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @user.liked_posts.delete(@post)
    respond_to do |format|
      format.html {render @post}
      format.js
    end
  end
end
