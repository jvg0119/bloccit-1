class SummariesController < ApplicationController
  
  def show
    set_summary
  end

  def new
    set_post
    @topic = @post.topic
    @summary = Summary.new
    authorize @summary
  end

  def create
    @summary = Summary.new(summary_params)
    @summary.post = set_post
    @topic = @post.topic
    authorize @summary
    
    if @summary.save
      flash[:notice] = "Summary was saved."
        
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the summary. Please try again."
      render :new
    end
    
  end

  private

    def summary_params
      params.require(:summary).permit(:body)
    end

    def set_topic
      @topic ||= Topic.find(params[:topic_id])
    end

    def set_post
      @post ||= Post.find(params[:post_id])
    end

    def set_summary
      @summary = set_post.summary
      authorize @summary
    end
  
end
