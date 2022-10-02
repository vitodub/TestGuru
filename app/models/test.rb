class Test < ApplicationRecord

  has_many :questions
  has_many :tests_users
  has_many :users, through: :usertests
  belongs_to :category
  belongs_to :author, class_name: :User, foreign_key: :author_id

	def self.title_by_category(name)
		Test.joins('INNER JOIN categories ON tests.category_id = categories.id')
		.where(categories: { title: name }).order(title: :desc)
		.pluck(:title)
	end
end
