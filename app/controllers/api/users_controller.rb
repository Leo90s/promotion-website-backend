module Api
  class UsersController < BaseController
    def index
      data = User.all
      data = data.where(index_params) if index_params.present?
      render_data paginated(data), serialize_option
    end

    def show
      data = User.find(params[:id])
      render_data data, serialize_option
    end

    def create
      data = User.create(user_params)
      render_data data, serialize_option
    end

    def update
      data = User.find(params[:id])
      data.update(user_params)
      render_data data, serialize_option
    end

    def destroy
      data = User.find(params[:id])
      data.destroy
      render_success
    end

    private

    def user_params
      params.permit(model_attributes - %i[password_digest] + %i[password])
    end

    def index_params
      params.permit(model_attributes - %i[password_digest])
    end
  end
end