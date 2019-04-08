class ApplicationController < ActionController::API
  def paginated(resource)
    resource.paginate(page: params[:page].presence || 1,
                      per_page: params[:per_page].presence || 20)
  end

  def collection_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries,
      per_page: params[:per_page].presence || 20
    }
  end

  def render_data(resource, options = {}, code = 0, msg = '')
    meta = { code: code, msg: msg }
    if resource.respond_to?(:total_entries) # record_collection必须带collection_meta给前端
      meta.merge!(collection_meta(resource))
    elsif resource.blank?
      data = resource.is_a?(Array) ? [] : {}
      return render_hash(data, code, msg)
    end
    response = {
      json: resource,
      root: 'data',
      meta: meta,
      include: options.delete(:include)
    }
    response.merge!(options) if options # options会成为serializer的instants_options
    render response
  end

  def render_success
    render_hash(success: true)
  end

  def render_hash(hash, code = 0, msg = '', extra = {})
    meta = { code: code, msg: msg }
    meta.merge!(extra) if extra.present?
    render json: { data: hash, meta: meta }
  end

  def render_error(msg, code = -1)
    render_hash({}, code, msg)
  end

  def order_args(res_class = resource_class)
    if params[:order_by]
      order_column = params[:order].split(' ')[0]
      order_type = params[:order].split(' ')[1]
      raise QueryOrderError unless res_class.attribute_names.include?(order_column)

      { order_column: order_type }
    else
      { created_at: 'desc' }
    end
  end

  def resource_name
    @resource_name ||= controller_name.singularize
  end

  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  def serialize(resource, options = {})
    ActiveModelSerializers::SerializableResource.new(resource, options.merge(adapter: :attributes))
  end

  def collection_serialize(resource, options = {})
    return [] unless resource

    ActiveModel::Serializer::CollectionSerializer.new(
      resource,
      options
    )
  end

  def require!(*keys)
    values = keys.map do |key|
      raise ActionController::ParameterMissing, "缺少参数#{key}" unless params[key]

      params[key]
    end
    values.size > 1 ? values : values.first
  end
end
