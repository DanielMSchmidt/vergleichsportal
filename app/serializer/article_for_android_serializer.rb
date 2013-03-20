class ArticleForAndroidSerializer < ActiveModel::Serializer

	attributes :id, :rating, :ratecount, :name, :ean, :author, :description, :article_type
	has_many :prices

	def rating
		object.average_rating
	end

	def ratecount
		object.ratings.size
	end

end