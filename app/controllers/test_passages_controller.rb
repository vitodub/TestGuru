class TestPassagesController < ApplicationController

  before_action :set_test_passage, only: %i[show result update]

  def show
    if @test_passage.test.has_timer?
      @timer = TimerService.new(@test_passage)
    end  
  end

  def result; end

  def update
    if params[:answer_ids].nil?
      redirect_to test_passage_path, notice: "You forgot to chose the answer"
    else
      @test_passage.accept!(params[:answer_ids])
      
      if @test_passage.completed?
        check_for_badges
        #TestsMailer.completed_test(@test_passage).deliver_now
        redirect_to result_test_passage_path(@test_passage)
      else
        render :show
      end
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id]) 
  end 

  def check_for_badges
    if @test_passage.success?
      @test_passage.update_attribute(:successful, true)
      BadgeService.new(@test_passage).call
    end
  end

end
