require 'csv'

class ConferenceCreator < ApplicationService
  def initialize(file)
    @conference = Conference.create!
    @file = file
  end

  def call
    process_file
  end

  private

  def process_file
    CSV.foreach(@file) do |row|
      duration = row.pop(1).first
      name = row.join(',')
      duration = 5 if duration == 'lightning'
      Lecture.create!(name: name, duration: duration, conference: @conference)
    end
    process_events
  end

  def lectures
    Lecture.not_assigned
  end

  def number_of_tracks
    (lectures.pluck(:duration).reduce(0, :+) / 420.0).ceil
  end

  def process_events
    number_of_tracks.times do |i|
      initial_time = '9:00'.to_time
      current_time = initial_time
      track = Track.create!(name: "Track #{i}", conference: @conference)

      while track.duration <= 180 - Lecture::LONG_DURATION && Lecture.long.not_assigned.count > 0
        current_time += 60.minutes
        lecture = Lecture.long.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 180 - Lecture::MEDIUM_DURATION && Lecture.medium.not_assigned.count > 0
        current_time = initial_time + 45.minutes
        lecture = Lecture.medium.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 180 - Lecture::SMALL_DURATION && Lecture.small.not_assigned.count > 0
        current_time += 30.minutes
        lecture = Lecture.small.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 180 - Lecture::LIGHTNING_DURATION && Lecture.lightning.not_assigned.count > 0
        current_time += 5.minutes
        lecture = Lecture.lightning.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      initial_time = '13:00'.to_time
      current_time = initial_time

      while track.duration <= 420 - Lecture::LONG_DURATION && Lecture.long.not_assigned.count > 0
        current_time += 60.minutes
        lecture = Lecture.long.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        p lecture.name, lecture.starts_at
        initial_time = lecture.ends_at
      end

      while track.duration <= 420 - Lecture::MEDIUM_DURATION && Lecture.medium.not_assigned.count > 0
        current_time = initial_time + 45.minutes

        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 420 - Lecture::SMALL_DURATION && Lecture.small.not_assigned.count > 0
        current_time += 30.minutes
        lecture = Lecture.small.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end

      while track.duration <= 420 - Lecture::LIGHTNING_DURATION && Lecture.lightning.not_assigned.count > 0
        current_time += 5.minutes
        lecture = Lecture.lightning.not_assigned.first
        track.lectures << lecture
        lecture.update!(starts_at: initial_time, ends_at: current_time)
        initial_time = lecture.ends_at
      end
    end

    @conference
  end
end
