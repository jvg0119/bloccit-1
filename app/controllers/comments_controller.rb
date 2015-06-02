class CommentsController < ApplicationController
  def create
    set_topic
    set_post
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    if @comment.save
      flash[:notice] = "Comment saved"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving your comment. Please try again."
      render 'posts/show'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_topic
      @topic ||= Topic.find(params[:topic_id])
    end

    def set_post
      @post ||= Post.find(params[:post_id])
    end

end
