require 'test_helper'

class BackgroundsTest < ActionDispatch::IntegrationTest
  setup do
    10.times{ create(:background, created_at: 2.days.ago)}
  end

  test '#index should return all backgrounds' do 
    get backgrounds_path
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal 10, json['backgrounds'].size
  end

  test '#index should return the newest backgrounds first' do
    @latest_background = create(:background, created_at: 5.minutes.ago)
    get backgrounds_path
    json = JSON.parse(response.body)
    assert_equal @latest_background.id, json['backgrounds'].first['id']
  end
end
