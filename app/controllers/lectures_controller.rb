class LecturesController < BaseController
  before_action :set_lecture, only: %i[show update destroy]

  def index
    lectures = Lecture.all

    render json: lectures, status: :ok
  end

  def show
    render json: @lecture, status: :ok
  end

  def create
    lecture = Lecture.create!(create_params)

    render json: lecture, status: :ok
  end

  def update
    @lecture.update!(update_params)

    render json: @lecture, status: :ok
  end

  def destroy
    render json: @lecture, status: :ok
  end

  private

  def create_params
    params.require(:lecture).permit(:name, :conference_id, :duration)
  end

  def update_params
    params.require(:lecture).permit(:name, :conference_id, :track_id, :starts_at, :ends_at)
  end

  def set_lecture
    @lecture = Lecture.find(params[:id])
  end
end
