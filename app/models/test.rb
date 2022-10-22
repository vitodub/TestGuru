class Test < ApplicationRecord

  has_many :questions
  has_many :usertests
  has_many :users, through: :usertests
  belongs_to :category
  belongs_to :author, class_name: :User, foreign_key: :author_id

  scope :select_easy, -> { where(level: 0..1) }
  scope :select_medium, -> { where(level: 2..4) }
  scope :select_hard, -> { where(level: 5..Float::INFINITY) }

  def self.title_by_category(name)
    Test.joins(:category)
    .where(category: { title: name }).order(title: :desc)
    .pluck(:title)
  end
end
