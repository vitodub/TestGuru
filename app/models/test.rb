class Test < ApplicationRecord
	def self.title_by_category(name)
		Test.joins('INNER JOIN categories ON tests.category_id = categories.id')
		.where(categories: { title: name }).order(title: :desc)
		.pluck(:title)
	end
end
