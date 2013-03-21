class CartForAndroidSerializer < ActiveModel::Serializer

	attributes :id, :last_update_date, :article_count

	def article_count
		object.articles.size
	end

	def last_update_date
		"#{object.updated_at.strftime("%Y-%m-%d %I:%M:%S %p")}"
	end

end