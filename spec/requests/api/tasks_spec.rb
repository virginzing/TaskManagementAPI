# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/tasks', type: :request do
  before do
    @user = User.create!(email: 'test@test.test', password: 'Test1234')
    @task = Tasks::CreateService.call(@user, { title: 'test' })[:value]
  end

  path '/tasks' do
    get 'List all tasks' do
      tags 'Tasks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :AuthenticationToken, in: :header, type: :string

      response '200', 'list of tasks' do
        let(:AuthenticationToken) { @user.email }

        schema '$ref' => '#/components/schemas/tasks_response'

        run_test!
      end

      response '422', 'invalid request' do
        let(:AuthenticationToken) { nil }

        schema '$ref' => '#/components/schemas/errors_response'

        run_test!
      end
    end
  end

  path '/tasks/{id}' do
    get 'Get task :id' do
      tags 'Tasks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :AuthenticationToken, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      let(:id) { @task.id }

      response '200', 'task data' do
        let(:AuthenticationToken) { @user.email }

        schema '$ref' => '#/components/schemas/task_response'

        run_test!
      end

      response '422', 'invalid request' do
        let(:AuthenticationToken) { nil }

        schema '$ref' => '#/components/schemas/errors_response'

        run_test!
      end
    end
  end

  path '/tasks' do
    post 'Creates a task' do
      tags 'Tasks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :AuthenticationToken, in: :header, type: :string
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          due_date: { type: :string },
          status: { type: :string }
        },
        required: [ 'title' ]
      }

      response '200', 'task created' do
        let(:AuthenticationToken) { @user.email }
        let(:task) { { title: 'foo' } }

        schema '$ref' => '#/components/schemas/task_response'

        run_test!
      end

      response '422', 'invalid request' do
        let(:AuthenticationToken) { @user.email }
        let(:task) { { title: '' } }

        schema '$ref' => '#/components/schemas/errors_response'

        run_test!
      end
    end
  end

  path '/tasks/{id}' do
    put 'Update task :id' do
      tags 'Tasks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :AuthenticationToken, in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          due_date: { type: :string },
          status: { type: :string }
        },
        required: [ 'title' ]
      }

      let(:id) { @task.id }

      response '200', 'task updated' do
        let(:AuthenticationToken) { @user.email }
        let(:task) { { title: 'foo' } }

        schema '$ref' => '#/components/schemas/task_response'

        run_test!
      end

      response '422', 'invalid request' do
        let(:AuthenticationToken) { @user.email }
        let(:task) { { title: '' } }

        schema '$ref' => '#/components/schemas/errors_response'

        run_test!
      end
    end
  end

  path '/tasks/{id}' do
    delete 'Delete task :id' do
      tags 'Tasks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :AuthenticationToken, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      let(:id) { @task.id }

      response '200', 'task deleted' do
        let(:AuthenticationToken) { @user.email }

        schema '$ref' => '#/components/schemas/task_response'

        run_test!
      end

      response '422', 'invalid request' do
        let(:AuthenticationToken) { nil }

        schema '$ref' => '#/components/schemas/errors_response'

        run_test!
      end
    end
  end

  path '/tasks/{id}/undo' do
    post 'Undo task :id' do
      tags 'Tasks'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :AuthenticationToken, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      let(:id) { @task.id }

      response '200', 'task undo' do
        let(:AuthenticationToken) { @user.email }

        schema '$ref' => '#/components/schemas/task_response'

        run_test!
      end

      response '422', 'invalid request' do
        let(:AuthenticationToken) { nil }

        schema '$ref' => '#/components/schemas/errors_response'

        run_test!
      end
    end
  end
end
