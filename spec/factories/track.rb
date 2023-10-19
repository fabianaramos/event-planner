FactoryBot.define do
  factory :track do
    name { 'Track 1' }
    conference { build(:conference) }
  end
end
