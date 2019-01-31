require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_create_black_name
    feedback = Feedback.new(name: '', feedback: 'Awesome!')

    assert_not_predicate feedback, :valid?
  end

  def test_create_black_feedback
    feedback = Feedback.new(name: 'Aradhya', feedback: '')

    assert_not_predicate feedback, :valid?
  end

  def test_create_valid
    feedback = Feedback.new(name: 'Aradhya', feedback: 'Awesome!')
    assert_predicate feedback, :valid?
  end
end
