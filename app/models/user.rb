class User < ApplicationRecord
	def test_by_level(test_level)
		Test.where(level: test_level)
        .joins('INNER JOIN usertests ON tests.id = usertests.test_id')
        .where(usertests: { user_id: self.id })
    end
end
