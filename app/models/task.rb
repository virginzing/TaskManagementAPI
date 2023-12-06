class Task < ApplicationRecord
  acts_as_paranoid

  belongs_to :created_by, class_name: "User"
  belongs_to :last_updated_by, class_name: "User"

  validates :title, presence: true

  def as_json(options = nil)
    {
      id: id,
      title: title,
      description: description,
      due_date: due_date,
      status: status,
      created_by: created_by,
      last_updated_by: last_updated_by,
      created_at: created_at,
      updated_at: updated_at,
      deleted_at: deleted_at,
      changelogs: changelogs
    }
  end
end
