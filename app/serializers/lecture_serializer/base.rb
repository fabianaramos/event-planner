module LectureSerializer
  class Base < ActiveModel::Serializer
    attributes :id, :name, :duration, :track_id, :conference_id, :created_at, :updated_at

    attribute(:starts_at) { object.starts_at_formatted }
    attribute(:ends_at) { object.ends_at_formatted }
  end
end
