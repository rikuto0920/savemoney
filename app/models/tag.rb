class Tag < ApplicationRecord
  validates :name, presence: true
  has_many :student_tag_relations, dependent: :destroy
  has_many :students, through: :student_tag_relations, dependent: :destroy
end
