require 'csv'

class Lecture < ApplicationRecord
  belongs_to :conference

  # validates presences

  # TODO: move for a service
  def self.process_file(file)
    conference = Conference.create!
    CSV.foreach(file) do |row|
      duration = row.pop(1).first
      name = row.join(',')
      duration = 5 if duration == 'lightning'
      lecture = conference.lectures.create!(name: name, duration: duration)
    end
  end
end
