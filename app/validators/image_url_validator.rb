#encoding: utf-8
class ImageUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^(http:\/\/){1}(www.){0,1}(\w|-|ö|ä|ü|\.)*\.(\w){2,3}(\/(\/|\S)*){1}(\.png|\.jpg|\.bmp|\.gif)$/
      record.errors[attribute] << (options[:message] || "is not an url, needs a leading http:// and has to end with one of .png, .jpg, .bmp, gif")
    end
  end
end
