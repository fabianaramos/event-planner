class TracksCreator < ApplicationService
  def initialize(conference)
    @conference = conference

    return unless @conference.tracks.exists?

    @conference.tracks.destroy_all
    @conference.lectures.update_all(track_id: nil)
  end

  def lectures
    p @conference.lectures.not_assigned, 'DEBUG:NOT ASSIGNED!'
    @conference.lectures.not_assigned
  end

  def number_of_tracks
    (lectures.pluck(:duration).reduce(0, :+) / 420.0).ceil
  end

  def call
    number_of_tracks.times do |i|
      i += 1
      initial_time = '9:00'.to_time
      current_time = initial_time
      track = Track.create!(name: "Track #{i}", conference: @conference)

      while track.duration <= 180 - Lecture::LONG_DURATION && @conference.lectures.long.not_assigned.count > 0
        current_time += 60.minutes
        lecture = @conference.lectures.long.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 180 - Lecture::MEDIUM_DURATION && @conference.lectures.medium.not_assigned.count > 0
        current_time = initial_time + 45.minutes
        lecture = @conference.lectures.medium.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 180 - Lecture::SMALL_DURATION && @conference.lectures.small.not_assigned.count > 0
        current_time += 30.minutes
        lecture = @conference.lectures.small.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 180 - Lecture::LIGHTNING_DURATION && @conference.lectures.lightning.not_assigned.count > 0
        current_time += 5.minutes
        lecture = @conference.lectures.lightning.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      initial_time = '13:00'.to_time
      current_time = initial_time

      while track.duration <= 420 - Lecture::LONG_DURATION && @conference.lectures.long.not_assigned.count > 0
        current_time += 60.minutes
        lecture = @conference.lectures.long.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        p lecture.name, lecture.starts_at
        initial_time = lecture.ends_at
      end

      while track.duration <= 420 - Lecture::MEDIUM_DURATION && @conference.lectures.medium.not_assigned.count > 0
        current_time = initial_time + 45.minutes
        lecture = @conference.lectures.medium.not_assigned.first

        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 420 - Lecture::SMALL_DURATION && @conference.lectures.small.not_assigned.count > 0
        current_time += 30.minutes
        lecture = @conference.lectures.small.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 420 - Lecture::LIGHTNING_DURATION && @conference.lectures.lightning.not_assigned.count > 0
        current_time += 5.minutes
        lecture = @conference.lectures.lightning.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end
    end
  end
end
