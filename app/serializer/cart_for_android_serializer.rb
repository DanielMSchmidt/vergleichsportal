class CartForAndroidSerializer < ActiveModel::Serializer

	attributes :id, :updated_at
	has_many :articles

end