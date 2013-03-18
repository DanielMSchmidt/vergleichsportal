#encoding: utf-8
class ImageUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)

    unless value =~ /^(http:\/\/){0,1}(www.){0,1}.*(\.png|\.jpg|\.bmp|\.png)$/
      record.errors[attribute] << (options[:message] || "is not an url")
    end
  end
end