class User < ApplicationRecord
  has_many :usertests
  has_many :tests, through: :usertests
  has_many :authortests, class_name: :Test, foreign_key: :author_id

  validates :name, :password, :email, presence: true

  def test_by_level(test_level)
    tests.where(test_level:)
  end
end
