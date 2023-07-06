class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 18, maximun: 70 }
  validates :body, presence: true, length: { minimum: 2000, maximun: 8000 }
end
