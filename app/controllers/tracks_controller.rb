class TracksController < BaseController
  before_action :set_conference
  before_action :set_track, only: %i[show]

  def index
    @tracks = @conference.tracks
                         .includes(:lectures)
                         .order(:created_at)

    render json: @tracks, each_serializer: ::TrackSerializer::List, status: :ok
  end

  def show
    render json: @track, serializer: ::TrackSerializer::Show, status: :ok
  end

  private

  def set_conference
    @conference = Conference.find(params[:conference_id])
  end

  def set_track
    @track = @conference.tracks.find(params[:id])
  end
end
