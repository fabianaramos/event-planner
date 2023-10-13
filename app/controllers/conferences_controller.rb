class ConferencesController < BaseController
  before_action :set_conference, only: %i[show update destroy]

  def index
    conferences = Conference.all

    render json: conferences, status: :ok
  end

  def show
    render json: @conference, status: :ok
  end

  def create; end

  def update
    render json: @conference, status: :ok
  end

  def destroy
    render json: @conference, status: :ok
  end

  private

  def set_conference
    @conference = Conference.find(params[:id])
  end
end
