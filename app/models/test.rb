class Test < ApplicationRecord

  has_many :questions
  has_many :usertests
  has_many :users, through: :usertests
  belongs_to :category
  belongs_to :author, class_name: :User, foreign_key: :author_id

	def self.title_by_category(name)
		Test.joins(:category)
		.where(category: { title: name }).order(title: :desc)
		.pluck(:title)
	end
end
