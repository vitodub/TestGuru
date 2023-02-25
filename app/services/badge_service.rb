class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @successful_passages = @user.test_passages.successful
    @test_title = test_passage.test.title
  end

  def call
    first_try_passed
    backend_passed
    easy_tests_passed    
  end

  private

  def first_try_passed
    if first_try_count == 1 && @test_passage.successful?
      give_badge('first_try_passed')
    end
  end

  def backend_passed
    if user_backend_tests_count == backend_tests_count
      give_badge('backend_passed')
    end
  end

  def easy_tests_passed
    if user_easy_tests_count == easy_tests_count
      give_badge('easy_tests_passed')
    end
  end

  def give_badge(title)
    @user.badges << Badge.where(title: title)
  end

  def first_try_count
    @successful_passages.joins(:test).where(test: { title: @test_title }).count
  end

  def user_backend_tests_count
    @successful_passages.joins(test: [:category]).where(category: { title: 'Backend' }).count
  end

   def backend_tests_count
    Test.joins(:category).where(category: { title: 'Backend' }).count
  end

  def user_easy_tests_count
    @successful_passages.joins(:test).where(test: { level: [0,1] }).count
  end

  def easy_tests_count
    Test.easy.where(visible: true).count
  end
end
