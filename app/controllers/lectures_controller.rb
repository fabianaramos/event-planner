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
    p params, 'paramsssss'
    lectures = Lecture.process_file(params[:file])

    render json: { "palestras": 'oiiii' }, status: :ok
  end

  def update
    render json: @lecture, status: :ok
  end

  def destroy
    render json: @lecture, status: :ok
  end

  private

  def set_lecture
    @lecture = Lecture.find(params[:id])
  end
end
