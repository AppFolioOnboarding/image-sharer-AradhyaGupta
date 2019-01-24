require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new_valid
    get new_image_path
    assert_response :ok
    assert_select 'form', count: 1
  end

  def test_show_image_found
    image = Image.create!(url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png')
    get image_path(image)
    assert_response :ok
    assert_select 'img', count: 1
  end

  def test_show_image_not_found
    get image_path(-1)
    assert_select 'img', count: 0
    assert_equal 'The page does not exist', flash[:danger]
  end

  def test_create_valid
    assert_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png'
      } }
    end
  end

  def test_create_invalid
    assert_no_difference 'Image.count' do
      post images_path, params: { image: {
        url: 'fafa'
      } }
      assert_response :unprocessable_entity
      assert_equal 'The action could not be completed', flash[:danger]
      assert_select 'div', text: 'The action could not be completed'
    end
  end

  def test_index__no_image
    Image.destroy_all
    get images_path
    assert_response :ok
    assert_select 'h1', 'Images'
    assert_select 'img', count: 0
  end

  def test_index
    Image.create!(url: 'https://learn.appfolio.com/apm/www/images/apm-logo-v2.png')
    get images_path
    assert_response :ok
    assert_select 'h1', 'Images'
  end

  def test_index__correct_order
    image_old = Image.create!(url: 'https://www.abc.com', created_at: 2.days.ago)
    image_new = Image.create!(url: 'https://www.xyz.com', created_at: 1.day.ago)

    get images_path

    assert_response :ok

    assert_select "li:first-of-type img[src='#{image_new.url}']", count: 1
    assert_select "li:last-of-type img[src='#{image_old.url}']", count: 1
  end

  def test_index_tag__correct_order
    Image.create!(url: 'https://www.abc.com', created_at: 2.days.ago, tag_list: %w[abc def])
    Image.create!(url: 'https://www.xyz.com', created_at: 1.day.ago, tag_list: ['ngh'])
    get images_path

    assert_response :ok

    assert_select 'li:last-of-type li:last-of-type', 'def'
    assert_select 'li:last-of-type li:first-of-type', 'abc'

    assert_select 'li:first-of-type li:first-of-type', 'ngh'

    assert_select 'li:first-of-type li', count: 1
    assert_select 'li:last-of-type li', count: 2
  end

  def test_index_with_no_tag
    Image.create!(url: 'https://www.abc.com', created_at: 2.days.ago)
    Image.create!(url: 'https://www.xyz.com', created_at: 1.day.ago, tag_list: ['ngh'])
    get images_path

    assert_response :ok

    assert_select 'li:last-of-type h4', count: 0
    assert_select 'li:first-of-type h4', count: 1
  end

  def test_show_with_no_tag
    image = Image.create!(url: 'https://www.abc.com', created_at: 2.days.ago)
    get image_path(image)

    assert_response :ok

    assert_select 'h4', count: 0
    assert_select 'img', count: 1
  end

  def test_show_with_tag
    image = Image.create!(url: 'https://www.abc.com', created_at: 2.days.ago, tag_list: ['ngh'])
    get image_path(image)

    assert_response :ok

    assert_select 'h4', count: 1
    assert_select 'img', count: 1
  end

  def test_index_search_by_tag_has_photos
    Image.create!(url: 'https://www.abc.com', created_at: 2.days.ago, tag_list: ['ngh'])
    Image.create!(url: 'https://www.def.com', created_at: 4.days.ago, tag_list: ['ngh'])
    Image.create!(url: 'https://www.ghi.com', created_at: 3.days.ago, tag_list: ['klm'])

    get tag_path('ngh')
    assert_response :ok
    assert_select '.js-tag_link', count: 2

    get tag_path('klm')
    assert_response :ok
    assert_select '.js-tag_link', count: 1

    get tag_path('abc')
    assert_response :ok
    assert_select '.js-tag_link', count: 0
  end

  def test_index_search_by_tag_has_no_photos
    get tag_path('abc')
    assert_response :ok
    assert_select 'li a', count: 0
    assert_equal 'The tag does not exist', flash[:danger]
  end
end
