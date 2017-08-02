class User < ApplicationRecord
  has_secure_password
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :display_name, :email, presence: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
