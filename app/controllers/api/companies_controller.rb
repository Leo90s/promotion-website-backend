module Api
  class CompaniesController < BaseController
    def index
      data = Company.all.order("created_at DESC")
      data = data.search(params[:search]).order("created_at DESC") if params[:search].present?
      data = data.where(company_params).order("created_at DESC") if company_params.present?
      render_data paginated(data), serialize_option
    end

    def show
      data = Company.find(params[:id])
      render_data data, serialize_option
    end

    def create
      data = Company.create(company_params)
      render_data data, serialize_option
    end

    def update
      data = Company.find(params[:id])
      data.update(company_params)
      render_data data, serialize_option
    end

    def destroy
      data = Company.find(params[:id])
      data.destroy
      render_success
    end

    def company_params
      params.permit(model_attributes)
    end
  end
end
