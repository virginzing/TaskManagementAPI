# frozen_string_literal: true

class Tasks::AddChangelogsService < ApplicationService
  attr_reader :task
  attr_reader :changes

  def initialize(task, changes)
    @task = task
    @changes = changes
  end

  def call
    logs = task.changelogs.append(previous_changes)

    task.update!(changelogs: logs)
  end

  private

  def previous_changes
    changes
      .map { |key, value| { key => value.first } }
      .reduce(&:merge)
      .merge(updated_at: task.updated_at)
  end
end
