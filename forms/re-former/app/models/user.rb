class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true
  validates :password, presence: true, length: { minumum: 12 }
end
