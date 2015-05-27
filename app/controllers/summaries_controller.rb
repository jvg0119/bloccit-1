class SummariesController < ApplicationController
  
  def show
    set_topic
    set_post
    set_summary
  end

  def new
    set_topic
    set_post
    @summary = Summary.new
    authorize @summary
  end

  def create
    set_topic
    set_post
    @summary = Summary.new(summary_params)
    @summary.post = @post
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
      @topic = Topic.find(params[:topic_id])
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_summary
      @summary = Summary.find(params[:id])
      authorize @summary 
    end
  
end
