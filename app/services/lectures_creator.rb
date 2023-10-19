require 'csv'

class LecturesCreator < ApplicationService
  def initialize(file, conference)
    @conference = conference
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
    TracksCreator.call(@conference)
  end
end
