class Lecture < ApplicationRecord
  LONG_DURATION = 60
  MEDIUM_DURATION = 45
  SMALL_DURATION = 30
  LIGHTNING_DURATION = 15

  belongs_to :conference
  belongs_to :track, optional: true

  validates :duration, :name, presence: true
  validate :ensure_lecture_will_not_be_overlapped

  scope :long, -> { where(duration: 60) }
  scope :medium, -> { where(duration: 45) }
  scope :small, -> { where(duration: 30) }
  scope :lightning, -> { where(duration: 5) }
  scope :assigned, -> { where.not(track: nil) }
  scope :not_assigned, -> { where(track: nil) }
  scope :in_range, lambda { |range|
                     where('starts_at >= ?', range.first.to_time).where('ends_at <= ?', range.last.to_time)
                   }

  private

  def ensure_lecture_will_not_be_overlapped
    range = Range.new starts_at, ends_at
    overlaps = track.lectures.in_range(range)

    errors.add(:starts_at, :invalid) unless overlaps.empty?
  end
end
