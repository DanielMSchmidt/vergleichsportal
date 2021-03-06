#encoding: utf-8
class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^(http:\/\/){1}(www.){0,1}(\w|\.|-)*\.(\w){2,3}(\/.*){0,1}$/
      record.errors[attribute] << (options[:message] || "is not an url, needs a leeding http://")
    end
  end
end
