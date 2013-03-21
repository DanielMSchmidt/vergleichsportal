class ProviderForAndroidSerializer < ActiveModel::Serializer

	attributes :id, :display_name, :url, :rating, :ratecount

	def rating
		object.average_rating
	end

	def ratecount
		object.ratings.size
	end

end