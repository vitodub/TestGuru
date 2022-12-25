class TestsController < ApplicationController

  before_action :set_test, only: %i[ show edit update destroy start ]
  
  def index
    @tests = Test.all
  end

  def edit; end

  def show; end

  def start
    set_user
    @user.tests.push(@test)
    redirect_to @user.test_passage(@test)    
  end

  private

  def set_test
    @test = Test.find(params[:id])    
  end

  def set_user
    @user = User.find_by(id: session[:user_id])
  end

end
