class Like < ApplicationRecord
  belongs_to :student
  belongs_to :user
  validates_uniqueness_of :student_id, scope: :user_id
end
