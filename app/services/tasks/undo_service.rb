# frozen_string_literal: true

class Tasks::UndoService < ApplicationService
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    return task if task.changelogs.empty?

    task.update!(task.changelogs.last)

    Tasks::DeleteChangelogsService.call(task)

    task.save

    task
  end
end
