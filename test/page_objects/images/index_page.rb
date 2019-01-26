module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: '.js-image_list', item_locator: '.js-image', contains: ImageCard

      def add_new_image!
        node.click_on('Add new image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        images.any? do |image|
          image.url == url && image.tags == tags
        end
      end

      def clear_tag_filter!
        node.click_on('Clear tag')
        window.change_to(IndexPage)
      end
    end
  end
end
