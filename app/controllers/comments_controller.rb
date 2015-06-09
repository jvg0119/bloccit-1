class CommentsController < ApplicationController
  def create
    set_post
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment saved"
    else
      flash[:error] = "There was an error saving your comment. Please try again."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    set_post
    @topic = @post.topic
    @comment = @post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comment couldn't be deleted.  Try again."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_post
      @post ||= Post.find(params[:post_id])
    end

end
