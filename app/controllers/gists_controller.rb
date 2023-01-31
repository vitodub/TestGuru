class GistsController < ApplicationController

  before_action :set_test_passage, only: :create 
  
  def create
    result = GistQuestionService.new(@test_passage.current_question)

    result.call

    flash_options = if result.success?
      @test_passage.current_question.gists.create(user_id: current_user.id, url: result.url)
      { notice: t('.success', link: result.url) }
    else
      { alert: t('.failure') }
    end
    
    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])    
  end 

end
