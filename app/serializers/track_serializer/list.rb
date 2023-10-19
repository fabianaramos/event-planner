module TrackSerializer
  class List < Base
    has_many :lectures

    class LectureSerializer < LectureSerializer::Base
    end
  end
end
