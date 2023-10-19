class Lecture < ApplicationRecord
  LONG_DURATION = 60
  MEDIUM_DURATION = 45
  SMALL_DURATION = 30
  LIGHTNING_DURATION = 15

  DURATIONS = [60, 45, 30, 5]

  belongs_to :conference
  belongs_to :track, optional: true

  validates :duration, :name, presence: true
  validates :duration, inclusion: { in: DURATIONS }

  after_destroy :destroy_track_if_it_is_empty

  scope :long, -> { where(duration: 60) }
  scope :medium, -> { where(duration: 45) }
  scope :small, -> { where(duration: 30) }
  scope :lightning, -> { where(duration: 5) }
  scope :assigned, -> { where.not(track: nil) }
  scope :not_assigned, -> { where(track: nil) }
  scope :in_range, lambda { |range|
                     where('starts_at >= ?', range.first.to_time).where('ends_at <= ?', range.last.to_time)
                   }

  def starts_at_formatted
    starts_at.strftime('%H:%M') if starts_at.present?
  end

  def ends_at_formatted
    ends_at.strftime('%H:%M') if ends_at.present?
  end

  private

  def destroy_track_if_it_is_empty
    return if track.nil?

    track.destroy unless track.lectures.exists?
  end
end
