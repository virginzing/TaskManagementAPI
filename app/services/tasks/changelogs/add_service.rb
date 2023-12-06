# frozen_string_literal: true

class Tasks::Changelogs::AddService < ApplicationService
  attr_reader :task
  attr_reader :changes

  def initialize(task, changes)
    @task = task
    @changes = changes
  end

  def call
    return if changes.empty?

    logs = task.changelogs.append(previous_changes)

    task.update!(changelogs: logs)
  end

  private

  def previous_changes
    { updated_at: task.updated_at }.merge(
      changes
        .map { |key, value| { key => value&.first } }
        .reduce(&:merge)
    )
  end
end
