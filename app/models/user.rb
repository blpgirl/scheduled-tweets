class User < ApplicationRecord
  has_many :twitter_accounts
  has_secure_password
  validates :password, presence: true
  validates :email, presence: true,
      format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "must be a valid email address"}
end
