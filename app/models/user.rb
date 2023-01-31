class User < ApplicationRecord
  
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :authortests, class_name: :Test, foreign_key: :author_id, dependent: :destroy
  has_many :gists

  validates :email, presence: true, uniqueness: true,
    format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }

  def test_by_level(test_level)
    tests.where(test_level: test_level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)    
  end

  def admin?
    is_a?(Admin)
  end

end


