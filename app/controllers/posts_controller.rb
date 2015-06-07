class PostsController < ApplicationController

  def show
    set_post
    set_topic
    authorize @topic
    @comments = @post.comments

    if current_user
      @comment = Comment.new
      authorize @comment, :new?
    end
  end

  def new
    set_topic
    @post = Post.new
    authorize @post
  end

  def create
    set_topic
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post

    if @post.save
      @post.create_vote
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end
  
  def edit
    set_topic
    set_post
  end

  def update
    set_topic
    set_post
    
    if @post.update_attributes(post_params)
        flash[:notice] = "Post was updated."
        redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    set_topic
    set_post

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :image)
    end

    def set_post
      @post = Post.find(params[:id])
      authorize @post
    end

    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

end
