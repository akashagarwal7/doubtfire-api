require 'test_helper'

class TasksTest < ActiveSupport::TestCase
  include Rack::Test::Methods
  include TestHelpers::AuthHelper
  include TestHelpers::JsonHelper

  def app
    Rails.application
  end

  # WIP
  def test_task_get
    # The GET we are testing
    get with_auth_token '/api/tasks?unit_id=1'
    expected_data = Unit.first.student_tasks.where('task_status_id > ?', 1)

    last_response_body.each_with_index do |r, i|
      #   assert_json_matches_model r, expected_data[i].as_json, ['id', 'tutorial_id', 'task_definition_id', 'status']
    end
  end

  def test_task_get_unauthorized
    get '/api/tasks?unit_id=1'

    assert_equal 419, last_response.status
  end

  def test_get_submission_details_unauthorized
    get '/api/projects/1/task_def_id/1/submission_details'

    assert_equal 419, last_response.status
  end
end
