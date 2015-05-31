class PostsController < ApplicationController

  def show
    set_post
    set_topic
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
      flash[:notice] = "Post was saved."
        
      # redirect extracts the id from @post
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
