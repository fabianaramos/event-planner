module ConferenceSerializer
  class Show < Base
    has_many :tracks

    class TrackSerializer < TrackSerializer::Base
      has_many :lectures
    end
  end
end
