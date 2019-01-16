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
    assert_equal 'The page does not exist', flash[:error]
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
end
