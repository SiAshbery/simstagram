class Photo < ApplicationRecord
    mount_uploader :image_file, PhotoUploader
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, :image_file, presence: true
end
