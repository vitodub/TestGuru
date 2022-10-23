class User < ApplicationRecord
  has_many :usertests, dependent: :destroy
  has_many :tests, through: :usertests, dependent: :destroy
  has_many :authortests, class_name: :Test, foreign_key: :author_id, dependent: :destroy

  validates :name, :password, :email, presence: true

  def test_by_level(test_level)
    tests.where(test_level:)
  end
end
