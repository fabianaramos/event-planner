module TrackSerializer
  class Show < Base
    has_many :lectures

    class LectureSerializer < LectureSerializer::Base
    end
  end
end
