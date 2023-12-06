# frozen_string_literal: true

class Tasks::CreateService < ApplicationService
  attr_reader :user
  attr_reader :task
  attr_reader :params

  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    @task = Task.new(params.merge({ created_by: user }))

    now = DateTime.now

    Tasks::Changelogs::AddService.call(user, task,
      {
        last_updated_by_id: user.id,
        updated_at: now,
        deleted_at: now
      }
    )

    return task if task.invalid?

    task.save

    task
  end
end
