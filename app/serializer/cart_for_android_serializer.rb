class CartForAndroidSerializer < ActiveModel::Serializer

	attributes :id, :updated_at, :article_count

	def article_count
		object.articles.size
	end

end