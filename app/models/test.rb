class Test < ApplicationRecord
  belongs_to :category

  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  has_many :questions, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :level, case_sensitive: false }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :by_category, ->(name) { joins(:category).where(category: { title: name }) }
  scope :visible, -> { where(visible: true) }

  def has_timer?
    self.timer > 0 
  end

  private

  def self.title_by_category(name)
    by_category(name).order(title: :desc).pluck(:title)
  end

end
