# frozen_string_literal: true

class Tasks::DeleteService < ApplicationService
  attr_reader :user
  attr_reader :task

  def initialize(user, task)
    @user = user
    @task = task
  end

  def call
    return task if task.deleted?

    Tasks::Changelogs::AddService.call(user, task, { deleted_at: nil })

    task.delete

    task
  end
end
