class CommentsController < ApplicationController
  def create
    set_topic_and_post
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    authorize @comment

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

    def set_topic_and_post
      @topic ||= Topic.find(params[:topic_id])
      @post ||= @topic.posts.find(params[:post_id])
    end

end
