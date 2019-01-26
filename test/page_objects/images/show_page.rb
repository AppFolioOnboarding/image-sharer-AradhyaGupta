module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      def image_present?(url)
        node.find("img[src=\"#{url}\"]").present?
      end

      def tags
        node.all('.js-tag_link').map(&:text)
      end

      def delete
        node.click_on('Delete')
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.click_on('Delete')
        box = node.driver.browser.switch_to.alert
        box.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        node.click_on('Index Page')
        window.change_to(IndexPage)
      end
    end
  end
end
