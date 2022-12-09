class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :less_than_4_answers, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def less_than_4_answer
    errors.add(:more_than_4_answers, "can't have more than 4 answers") if question.answers.count > 3 
  end
end
