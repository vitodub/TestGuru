class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :usertests
  has_many :authortests, class_name: :Test, foreign_key: :author_id


  def test_by_level(test_level)
    Test.where(level: test_level)
    .joins('INNER JOIN usertests ON tests.id = usertests.test_id')
    .where(usertests: { user_id: self.id })
  end
end
