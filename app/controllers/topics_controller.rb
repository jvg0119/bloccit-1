class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    @topics = Topic.paginate(page: params[:page], per_page: 10)
    authorize @topics
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def show
    set_topic
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
  end

  def edit
    set_topic
  end

  def create
    # I had already implemented this assignments specs - (topic_params)
    @topic = Topic.new(topic_params)
    authorize @topic

    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully"
    else
      flash[:error] = "Error creating topic, Please try again."
      render :new
    end
  end

  def update
    set_topic
    # I had already implemented this assignments specs - (topic_params)
    if @topic.update_attributes(topic_params)
      redirect_to @topic
    else
      flash[:error] = "Error saving topic, Please try again."
      render :edit
    end
  end

  def destroy
    set_topic

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end

  private

    # I had already implemented this assignments specs - (topic_params)
    def topic_params
      params.require(:topic).permit(:name, :description, :public)
    end

    def set_topic
      @topic ||= Topic.find(params[:id])
      authorize @topic
    end
end
