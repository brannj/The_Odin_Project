class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { maximum: 50 }
  validates :body, length: { maximum: 255 }
end
