class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  has_many :artists, dependent: :destroy
  has_many :live_schedules, dependent: :destroy
  has_many :live_records, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :categories, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: { maximum: 10 }
end
