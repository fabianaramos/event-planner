class Track < ApplicationRecord
  validates :name, presence: true

  belongs_to :conference
  has_many :lectures, lambda {
                        order(starts_at: :asc)
                      }

  def duration
    lectures.pluck(:duration).reduce(0, :+)
  end
end
