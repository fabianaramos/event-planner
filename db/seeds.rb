# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

conference = Conference.create!(name: 'Dev Conference')

Track.create!(name: 'Track 1', conference: conference)
Track.create!(name: 'Track 2', conference: conference)

CSV.foreach('public/lectures.csv') do |row|
  duration = row.pop(1).first
  name = row.join(',')
  duration = 5 if duration == 'lightning'
  lecture = conference.lectures.create!(name: name, duration: duration)
end
