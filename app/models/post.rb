class Post < ApplicationRecord
  belongs_to :user

  validates :name, :body, presence: true
end
