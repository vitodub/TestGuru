class TestPassage < ApplicationRecord
  PASS_PERCENT = 85.freeze

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  after_validation :after_validation_set_next_question, on: :update

  scope :successful, -> { where(successful: true) }

  def completed?
    current_question.nil?    
  end

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    save!
  end

  def correct_percent
    ((self.correct_questions.to_f / 
    self.test.questions.count.to_f) * 100).to_int
  end

  def success?
    correct_percent > PASS_PERCENT
  end

  def question_number
    self.test.questions.count -
    self.test.questions.where('id > ?', self.current_question.id).count
  end

  def progress
    ((( question_number.to_f - 1) / self.test.questions.count.to_f) * 100).to_int
  end

  def is_successful
    self.successful = true
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def after_validation_set_next_question
    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first    
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

end
