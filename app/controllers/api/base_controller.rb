class Api::BaseController < ApplicationController
  before_action :init_resource, only: [:show, :destroy, :update]

  def index
    data = paginated(index_data)
    render_data data, list_serialize_option
  end

  def show
    render_data controller_resource, serialize_option
  end

  def create
    data = resource_class.create!(resource_params)
    render_data data, serialize_option
  end

  def update
    controller_resource.update!(update_params)
    render_data controller_resource, serialize_option
  end

  def destroy
    if controller_resource.destroy # before_destroy 抛出的异常无法获取自定义的error message
      render_success
    else
      render_error controller_resource.errors.full_message.join(',')
    end
  end

  private

  def index_data
    base_index_query.where(query_params).order(order_args)
  end

  def query_params(res_class = resource_class)
    querys = {}
    res_class.attribute_names.each do |attr|
      querys[attr] = params[attr].split(',') if params[attr].present?
    end
    querys
  end

  def init_resource(resource = nil)
    resource ||= resource_class.find_by!(id: params[:id])
    instance_variable_set("@#{resource_name}", resource)
  end

  def list_serialize_option
    serialize_option
  end

  def serialize_option
    {}
  end

  def resource_params
    @resource_params ||= send("#{resource_name}_params")
  end

  def update_params
    resource_params
  end

  def base_index_query
    resource_class
  end

  def controller_resource
    instance_variable_set("@#{resource_name}")
  end

  def model_attributes
    resource_class.attribute_names.map(&:to_sym) - %i[created_at updated_at id]
  end

  def index_includes
    nil
  end
end
