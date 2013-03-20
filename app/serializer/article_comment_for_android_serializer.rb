class ArticleCommentForAndroidSerializer < ActiveModel::Serializer

	attributes :comment, :author

	def comment
		"#{object.value}"
	end

	def author
		"#{User.find(object.user_id).email}"
	end

end