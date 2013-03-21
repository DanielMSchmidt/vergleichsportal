class ArticleInCartForAndroidSerializer < ActiveModel::Serializer

	attributes :count_in_cart, :id, :ean, :title, :imageURL, :description, :type, :rating, :ratecount, :author, :prices

	def count_in_cart
		object.quantity
	end

	def imageURL
		"#{object.article.images[0].url}"
	end

	def title
		"#{object.article.name}"
	end

	def id
		object.article.id
	end

	def ean
		object.article.ean
	end

	def description
		object.article.description
	end

	def author
		object.article.author
	end

	def type
		"#{object.article_type}"
	end

	def rating
		object.article.average_rating
	end

	def ratecount
		object.article.ratings.size
	end

	def prices
		object.article.prices
	end

end