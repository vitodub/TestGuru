class TimerService

  attr_reader :time_left

  def initialize(test_passage)
    @timer = test_passage.test.timer
    @start = test_passage.created_at
    @finish = @start + "#{@timer}".to_i.minutes
    @time_left = (@finish - Time.now).to_int
  end
end
