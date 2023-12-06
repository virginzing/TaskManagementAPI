# frozen_string_literal: true

class Tasks::DeleteChangelogsService < ApplicationService
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    logs = task.changelogs

    return if logs.empty?

    logs.pop

    task.update!(changelogs: logs)
  end
end
