# frozen_string_literal: true

class Tasks::UpdateService < ApplicationService
  attr_reader :task
  attr_reader :params

  def initialize(task, params)
    @task = task
    @params = params
  end

  def call
    task.assign_attributes(params)

    return task if task.invalid?

    Tasks::Changelogs::AddService.call(task, task.changes)

    task.save

    task
  end
end
