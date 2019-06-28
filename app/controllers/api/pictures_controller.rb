module Api
  class PicturesController < BaseController
    def index
      data = Picture.all
      data = data.where(picture_params) if picture_params.present?
      render_data paginated(data), serialize_option
    end

    def create
      data = Picture.create(picture_params)
      render_data data, serialize_option
    end

    def destroy
      data = Picture.find(params[:id])
      data.destroy
      render_success
    end

    private

    def picture_params
      params.permit(:file)
    end
  end
end
