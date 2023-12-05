class Task < ApplicationRecord
  acts_as_paranoid

  belongs_to :created_by, class_name: "User"
  belongs_to :last_updated_by, class_name: "User"
end
