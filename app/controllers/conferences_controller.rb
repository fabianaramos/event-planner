class ConferencesController < BaseController
  before_action :set_conference, only: %i[show edit update destroy]

  def index
    @conferences = Conference.all
                             .order(created_at: :desc)

    respond_to do |format|
      format.json { render json: @conferences, each_serializer: ::ConferenceSerializer::List, status: :ok }
      format.html
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @conference, serializer: ::ConferenceSerializer::Show, status: :ok }
      format.html
    end
  end

  def new
    @conference = Conference.new
  end

  def create
    @conference = Conference.new(create_params)

    if @conference.save
      respond_to do |format|
        format.json { render json: @conference, serializer: ::ConferenceSerializer::Show, status: :created }
        format.html { redirect_to conference_path @conference }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @conference
  end

  def update
    if @conference.update(update_params)
      respond_to do |format|
        format.json { render json: @conference, serializer: ::ConferenceSerializer::Show, status: :ok }
        format.html { redirect_to @conference }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @conference.destroy!

    respond_to do |format|
      format.json { render json: @conference, serializer: ::ConferenceSerializer::Show, status: :ok }
      format.html { redirect_to root_path, status: :see_other }
    end
  end

  private

  def create_params
    params.require(:conference).permit(:name)
  end

  def update_params
    params.require(:conference).permit(:name)
  end

  def set_conference
    @conference = Conference.find(params[:id])
  end
end
