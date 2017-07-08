class Photo < ApplicationRecord
    mount_uploader :image_file, PhotoUploader
    belongs_to :user
    validates :title, :image_file, presence: true
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
end
