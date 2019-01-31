require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'should create a feedback' do
    assert_difference 'Feedback.count' do
      post api_feedbacks_path, params: { feedback: {
        name: 'Aradhya',
        feedback: 'Awesome!'
      } }
    end
  end
end
