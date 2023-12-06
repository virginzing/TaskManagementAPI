# frozen_string_literal: true

class Tasks::DeleteChangelogsService < ApplicationService
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    task.changelogs.pop
    logs = task.changelogs

    task.update!(changelogs: logs)
  end
end
