class GistsController < ApplicationController

  before_action :set_test_passage, only: :create 
  
  def create
    result = GistQuestionService.new(@test_passage.current_question).call
    
    flash_options = if result.success?
      @test_passage.current_question.gists.create(user_id: current_user.id, url: result.gist_url)
      { notice: t('.success', link: result.gist_url) }
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
