class Article < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 18, maximun: 70 }
  validates :body, presence: true, length: { minimum: 2000, maximun: 8000 }

  VALID_STATUSES = %w[public private archived].freeze

  validates :status, inclusion: { in: VALID_STATUSES }

  def archived?
    status == 'archived'
  end
end
