class Test < ApplicationRecord

  has_many :questions
  has_many :usertests
  has_many :users, through: :usertests
  belongs_to :category
  belongs_to :author, class_name: :User, foreign_key: :author_id

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :by_category, ->(name) { joins(:category).where(category: { title: name }) }

  def self.title_by_category(name)
    by_category(name).order(title: :desc).pluck(:title)
  end
end
