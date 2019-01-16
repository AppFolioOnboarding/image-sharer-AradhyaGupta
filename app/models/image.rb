class HttpUrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    uri = URI.parse(value)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'is not a valid HTTP URL') unless self.class.compliant?(value)
  end
end

class Image < ApplicationRecord
  acts_as_taggable_on :tags

  validates :url, presence: true
  validates :url, http_url: true
end
