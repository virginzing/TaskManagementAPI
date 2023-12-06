# frozen_string_literal: true

class Tasks::DeleteService < ApplicationService
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    return task if task.deleted?

    Tasks::Changelogs::AddService.call(task, { deleted_at: nil })

    task.delete

    task
  end
end
