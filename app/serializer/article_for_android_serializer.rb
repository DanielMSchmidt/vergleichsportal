class ArticleForAndroidSerializer < ActiveModel::Serializer

	attributes :id, :rating, :ratecount, :title, :ean, :author, :description, :type, :imageURL
	has_many :prices

	def imageURL
		"#{object.images[0].url}"
	end

	def title
		"#{object.name}"
	end

	def type
		"#{object.article_type}"
	end

	def rating
		object.average_rating
	end

	def ratecount
		object.ratings.size
	end

end