class Answer < ApplicationRecord
	belongs_to :question

	scope :is_correct, -> { where(correct: true) }
end
