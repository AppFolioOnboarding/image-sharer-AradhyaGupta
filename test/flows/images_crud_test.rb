require 'flow_test_helper'

class ImagesCrudTest < FlowTestCase
  test 'add an image' do
    images_index_page = PageObjects::Images::IndexPage.visit

    new_image_page = images_index_page.add_new_image!

    tags = %w[foo bar]
    new_image_page = new_image_page.create_image!(
      url: 'invalid',
      tags: tags.join(', ')
    ).as_a(PageObjects::Images::NewPage)
    assert_equal 'Url is not a valid HTTP URL', new_image_page.url.error_message

    image_url = 'https://media3.giphy.com/media/EldfH1VJdbrwY/200.gif'
    new_image_page.url.set(image_url)

    image_show_page = new_image_page.create_image!
    assert_equal 'You have successfully added an image.', image_show_page.flash_message(:success)

    assert image_show_page.image_present?(image_url)
    assert_equal tags, image_show_page.tags

    images_index_page = image_show_page.go_back_to_index!
    assert images_index_page.showing_image?(url: image_url, tags: tags)
  end

  test 'delete an image' do
    images_index_page = PageObjects::Images::IndexPage.visit

    new_image_page = images_index_page.add_new_image!

    image_url = 'https://media3.giphy.com/media/EldfH1VJdbrwY/200.gif'
    new_image_page.url.set(image_url)

    image_show_page = new_image_page.create_image!
    image_show_page.delete do |confirm_dialog|
      assert_equal 'Are you sure?', confirm_dialog.text
      confirm_dialog.dismiss
    end
    assert_difference 'Image.count',-1 do
      image_show_page.delete_and_confirm!
    end
  end

  test 'view images associated with a tag' do
    puppy_url1 = 'http://www.pawderosa.com/images/puppies.jpg'
    puppy_url2 = 'http://ghk.h-cdn.co/assets/16/09/980x490/landscape-1457107485-gettyimages-512366437.jpg'
    cat_url = 'https://assets3.thrillist.com/v1/image/2531559/size/tmg-article_tall;jpeg_quality=20.jpg'
    images = Image.create!([
      { url: puppy_url1, tag_list: 'superman, cute' },
      { url: puppy_url2, tag_list: 'cute, puppy' },
      { url: cat_url, tag_list: 'cat, ugly' }
    ])

    images_index_page = PageObjects::Images::IndexPage.visit
    images.each do |image|
      assert images_index_page.showing_image?(url: image.url, tags: image.tag_list )
    end

    images_index_page = images_index_page.images[1].click_tag!('cute')
    assert_equal 2, images_index_page.images.count
    assert_not images_index_page.showing_image?(url: cat_url)

    images_index_page = images_index_page.clear_tag_filter!
    assert_equal 3, images_index_page.images.count
  end
end
