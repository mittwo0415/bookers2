class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  
  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end
end
