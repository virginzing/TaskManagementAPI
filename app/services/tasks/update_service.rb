# frozen_string_literal: true

class Tasks::UpdateService < ApplicationService
  attr_reader :user
  attr_reader :task
  attr_reader :params

  def initialize(user, task, params)
    @user = user
    @task = task
    @params = params
  end

  def call
    task.assign_attributes(params)

    return task if task.invalid?

    Tasks::Changelogs::AddService.call(user, task, task.changes)

    task.save

    task
  end
end
