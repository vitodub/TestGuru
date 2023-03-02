class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @successful_passages = @user.test_passages.successful
    @test_title = test_passage.test.title
  end

  def call
    Badge.all.each do |badge|
      give_badge(badge) if send(badge.title, badge.parametr)
    end
  end

  private

  def first_try_passed(parametr)
    first_try_count == 1 && @test_passage.successful?
  end

  def category_passed(parametr)
    user_tests_count_by_category(parametr) == count_tests_by_category(parametr)
  end

  def difficulty_passed(parametr)
    user_tests_count_by_difficulty_level(parametr.split) == count_tests_by_difficulty_level(parametr.split)
  end

  def give_badge(badge)
    @user.badges << badge
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
