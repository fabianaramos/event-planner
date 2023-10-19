class Conference < ApplicationRecord
  has_many :tracks, dependent: :destroy
  has_many :lectures, dependent: :destroy

  validates :name, presence: true
end
