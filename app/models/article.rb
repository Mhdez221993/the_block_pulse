class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 18, maximun: 70 }
  validates :body, presence: true, length: { minimum: 2000, maximun: 10000 }
end
