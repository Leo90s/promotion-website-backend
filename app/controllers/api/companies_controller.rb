module Api
  class CompaniesController < BaseController
    def index
      data = Company.all.order("created_at DESC")
      data = data.search(params[:search]).order("created_at DESC") if params[:search].present?
      render_data paginated(data), serialize_option
    end

    def company_params
      params.permit(model_attributes)
    end
  end
end
