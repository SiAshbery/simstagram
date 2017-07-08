class User < ApplicationRecord

    has_secure_password
    has_many :photos, dependent: :destroy
    validates :display_name, :email, presence: true
    has_many :comments

end
