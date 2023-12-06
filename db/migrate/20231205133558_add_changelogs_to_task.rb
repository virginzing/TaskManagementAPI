class AddChangelogsToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :changelogs, :jsonb, default: []
  end
end
