class StudentTagRelation < ApplicationRecord
  belongs_to :student
  belongs_to :tag
end
