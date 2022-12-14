class Admin::TestsController < Admin::BaseController

  before_action :set_test, only: %i[ show edit update destroy ]
  
  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def edit; end

  def create
    @test = current_user.authortests.new(test_params)
  
    if @test.save
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test]
    else
      render :edit
    end
  end

  private

  def set_test
    @test = Test.find(params[:id])    
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id)     
  end

end
