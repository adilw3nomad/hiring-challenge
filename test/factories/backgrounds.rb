# frozen_string_literal: true

FactoryBot.define do
  factory :background do
    name { Faker::TvShows::RickAndMorty.character }
    url  { Faker::Internet.url }
    comment { Faker::TvShows::RickAndMorty.quote }
    image { FilesHelper.jpg }
  end
end
