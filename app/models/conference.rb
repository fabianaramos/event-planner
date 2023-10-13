class Conference < ApplicationRecord
  has_many :lectures, dependent: :destroy
end
