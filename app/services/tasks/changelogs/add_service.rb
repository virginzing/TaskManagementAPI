# frozen_string_literal: true

class Tasks::Changelogs::AddService < ApplicationService
  attr_reader :user
  attr_reader :task
  attr_reader :changes

  def initialize(user, task, changes)
    @user = user
    @task = task
    @changes = changes
  end

  def call
    return if changes.empty?

    logs = task.changelogs.append(previous_changes)

    task.assign_attributes(last_updated_by: user, changelogs: logs)
  end

  private

  def previous_changes
    {
      last_updated_by_id: task.last_updated_by_id,
      updated_at: task.updated_at
    }.merge(
      changes
        .map { |key, value| { key => previous_data(value) } }
        .reduce(&:merge)
    )
  end

  def previous_data(value)
    return nil if value.nil?
    return value.first if value.is_a?(Array)

    value
  end
end
