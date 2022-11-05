class ItemLimitedSerializer < ActiveModel::Serializer
    attributes :id, :name, :price
end