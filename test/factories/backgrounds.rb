include ActionDispatch::TestProcess
FactoryBot.define do
  factory :background do
    name {Faker::TvShows::RickAndMorty.character }
    url  { Faker::Internet.url }
    comment { Faker::TvShows::RickAndMorty.quote }
    image { fixture_file_upload(Rails.root.to_s + '/test/fixtures/files/rick.jpg', 'image/jpg') }
  end
end
