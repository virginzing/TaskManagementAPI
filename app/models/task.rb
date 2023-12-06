# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id                 :integer          not null, primary key
#  changelogs         :json
#  deleted_at         :datetime
#  description        :string
#  due_date           :datetime
#  status             :string
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  created_by_id      :integer          not null
#  last_updated_by_id :integer          not null
#
# Indexes
#
#  index_tasks_on_created_by_id       (created_by_id)
#  index_tasks_on_deleted_at          (deleted_at)
#  index_tasks_on_last_updated_by_id  (last_updated_by_id)
#
# Foreign Keys
#
#  created_by_id       (created_by_id => users.id)
#  last_updated_by_id  (last_updated_by_id => users.id)
#
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
