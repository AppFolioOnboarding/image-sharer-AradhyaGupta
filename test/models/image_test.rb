require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_create__invalid_url
    image = Image.new(url: 'fafa')

    assert_not_predicate image, :valid?
    assert_equal 'is not a valid HTTP URL', image.errors.messages[:url][0]
  end

  def test_create__black_url
    image = Image.new(url: '')
    assert_not_predicate image, :valid?

    assert_equal "can't be blank", image.errors.messages[:url][0]
  end

  def test_create__valid_url
    image = Image.new(url: 'https://cps-static.rovicorp.com/3/JPG_400/MI0004/200/MI0004200164.jpg?partner=allrovi.com')

    assert_predicate image, :valid?
  end
end
