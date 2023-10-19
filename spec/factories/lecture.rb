FactoryBot.define do
  factory :lecture do
    name { 'Rails: oriented object programming' }
    duration { 60 }
    conference { build(:conference) }
    track { build(:track) }
    starts_at { '10:00'.to_time }
    ends_at { '11:00'.to_time }
  end
end
