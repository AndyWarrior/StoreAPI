class OrderSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :user_id, :amount
end
