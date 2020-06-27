require 'test_helper'

class BackgroundsTest < ActionDispatch::IntegrationTest
  setup do
    9.times{ create(:background, created_at: 2.days.ago)}
    @latest_background = create(:background, created_at: 5.minutes.ago)
  end
  class IndexActionTest < BackgroundsTest
    test 'it should return all backgrounds' do
      get backgrounds_path format: :json
      assert_response :success
      json = JSON.parse(response.body)
      assert_equal 10, json['backgrounds'].size
    end

    test 'it should return the newest backgrounds first' do
      get backgrounds_path format: :json
      json = JSON.parse(response.body)
      assert_equal @latest_background.id, json['backgrounds'].first['id']
    end

    test 'it should respond to xml requests' do
      get backgrounds_path format: :xml
      assert_response :success
      assert_equal 'application/xml', response.media_type
      hashed_xml = Hash.from_xml(response.body)
      actual = hashed_xml['backgrounds']['background'].first
      assert_equal @latest_background.id.to_s, actual['id']
    end
  end
end
