class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @successful_passages = @user.test_passages.successful
    @test_title = test_passage.test.title
  end

  def call
    Badge.all.each do |badge|
      give_badge(badge.title) if send(badge.title)
    end
  end

  private

  def first_try_passed
    first_try_count == 1 && @test_passage.successful?
  end

  def backend_passed
    user_tests_count_by_category('Backend') == count_tests_by_category('Backend')
  end

  def easy_tests_passed
    user_tests_count_by_difficulty_level([0,1]) == count_tests_by_difficulty_level([0,1])
  end

  def give_badge(title)
    @user.badges << Badge.where(title: title)
  end

  def first_try_count
    @successful_passages.joins(:test).where(test: { title: @test_title }).count
  end

  def user_tests_count_by_category(category)
    @successful_passages.joins(test: [:category]).where(category: { title: category }).count
  end

   def count_tests_by_category(category)
    Test.joins(:category).where(category: { title: category }, visible: true).count
  end

  def user_tests_count_by_difficulty_level(level)
    @successful_passages.joins(:test).where(test: { level: level }).count
  end

  def count_tests_by_difficulty_level(level)
    Test.where(level: level, visible: true).count
  end
end
