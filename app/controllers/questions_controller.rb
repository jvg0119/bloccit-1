class QuestionsController < ApplicationController
  
  def index
    @questions = Question.all
  end

  def show
    set_question
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "Question was saved."
        
      # redirect_to extracts the id from @question
      redirect_to @question
    else
      flash[:error] = "There was an error saving the question. Please try again."
      render :new
    end
  end

  def edit
    set_question
  end

  def update
    set_question
    if @question.update_attributes(question_params)
        flash[:notice] = "Question was updated."
        redirect_to @question
    else
      flash[:error] = "There was an error saving the question. Please try again."
      render :edit
    end
  end

  def destroy
    set_question.destroy
    flash[:notice] = "Question Deleted Successfully"
    redirect_to questions_path
  end

  private

    def question_params
      params.require(:question).permit(:title, :body, :resolved)
    end

    def set_question
      @question = Question.find(params[:id])
    end

end
