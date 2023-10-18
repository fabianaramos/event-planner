class Track < ApplicationRecord
  belongs_to :conference
  has_many :lectures, dependent: :destroy

  def duration
    lectures.pluck(:duration).reduce(0, :+)
  end
end
