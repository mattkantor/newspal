FactoryBot.define do
  factory :item do
    title Faker::Seinfeld.quote
    source_id 1
    body  Faker::TwinPeaks.quote
    published Faker::Time.between(DateTime.now - 5, DateTime.now)
    image_url ""
    url ""
    sentiment 1

  end
end
