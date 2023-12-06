# frozen_string_literal: true

class Tasks::UndoService < ApplicationService
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def call
    if task.changelogs.empty?
      task.errors.add(:changelogs, 'is empty')

      return FAILED(task)
    end

    task.assign_attributes(task.changelogs.last)

    Tasks::Changelogs::PopService.call(task)

    task.save!

    SUCCESS(task)
  end
end
