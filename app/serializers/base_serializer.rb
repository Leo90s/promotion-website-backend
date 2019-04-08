class BaseSerializer < ActiveModel::Serializer
  def serialize(resource, options = {})
    ActiveModelSerializers::SerializableResource.new(
      resource,
      options
    )
  end

  def collection_serialize(resource, options = {})
    return [] unless resource

    ActiveModel::Serializer::CollectionSerializer.new(
      resource,
      options
    )
  end
end