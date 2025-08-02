class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :prof, ImageUploader

  has_many :students, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_students, through: :likes, source: :student

  validates :name, presence: true 
  validates :profile, length: { maximum: 200 }       

  def already_liked?(student)
    likes.exists?(student_id: student.id)
  end
end
