class LecturesController < BaseController
  before_action :set_conference
  before_action :set_lecture, only: %i[show update destroy]

  def index
    @lectures = @conference.lectures
                           .order(:starts_at)

    respond_to do |format|
      format.json { render json: @lectures, each_serializer: ::LectureSerializer::List, status: :ok }
      format.html
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @lecture, serializer: ::LectureSerializer::Show, status: :ok }
      format.html
    end
  end

  def create
    @lecture = Lecture.new(create_params)

    return unless @lecture.save

    TracksCreator.call(@conference)
    respond_to do |format|
      format.json { render json: @lecture, serializer: ::LectureSerializer::Show, status: :created }
      format.html { redirect_to conference_path(@conference) }
    end
  end

  def create_batch
    LecturesCreator.call(params[:file], @conference)

    respond_to do |format|
      format.json do
        render json: @conference.tracks, each_serializer: ::TrackSerializer::Show, include: '**', status: :ok
      end
      format.html { redirect_to conference_path(@conference) }
    end
  end

  def edit
    @lecture
  end

  def update
    if @lecture.update(update_params)
      TracksCreator.call(@conference)
      respond_to do |format|
        format.json { render json: @lecture, serializer: LectureSerializer::Show, status: :ok }
        format.html { redirect_to @conference }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lecture.destroy!

    respond_to do |format|
      format.json { render json: @lecture }
      format.html { redirect_to conference_path(@conference) }
    end
  end

  private

  def create_params
    params.require(:lecture).permit(:name, :duration).merge(conference_id: params[:conference_id])
  end

  def update_params
    params.require(:lecture).permit(:name, :duration)
  end

  def create_batch_params
    params.permit(:file, :conference_id)
  end

  def set_conference
    @conference = Conference.find(params[:conference_id])
  end

  def set_lecture
    @lecture = @conference.lectures.find(params[:id])
  end
end
