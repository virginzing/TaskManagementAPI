# frozen_string_literal: true

class Tasks::UndoService < ApplicationService
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    return task if task.changelogs.empty?

    task.assign_attributes(task.changelogs.last)

    Tasks::Changelogs::PopService.call(task)

    task.save

    task
  end
end
