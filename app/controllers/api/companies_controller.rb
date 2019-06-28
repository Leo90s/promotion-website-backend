module Api
  class CompaniesController < BaseController
    def index
      data = Company.all
      data = data.search(params[:search]) if params[:search].present?
      data = data.where(company_params) if company_params.present?
      render_data paginated(data).order("created_at DESC"), serialize_option
    end

    def show
      data = Company.find(params[:id])
      render_data data, serialize_option
    end

    def create
      company = Company.create!(company_params)
      images = Picture.find(params[:picture_ids])
      company.pictures << images
      render_data company, serialize_option
    end

    def update
      data = Company.find(params[:id])
      if params[:picture_ids].present?
        data.pictures.destroy_all
        images = Picture.find(params[:picture_ids])
        data.pictures << images
      end 
      data.update(company_params)
      render_data data, serialize_option
    end

    def destroy
      data = Company.find(params[:id])
      data.destroy
      render_success
    end

    private

    def company_params
      params.permit(model_attributes + %i[picture_ids])
    end
  end
end
