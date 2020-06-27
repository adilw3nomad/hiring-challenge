require 'test_helper'

class BackgroundsTest < ActionDispatch::IntegrationTest
  setup do
    9.times{ create(:background, created_at: 2.days.ago)}
    @background = create(:background, created_at: 5.minutes.ago)
  end

  class IndexActionTest < BackgroundsTest
    test 'it should return all backgrounds' do
      get backgrounds_path format: :json
      json = JSON.parse(response.body)
      
      assert_response :success
      assert_equal 10, json['backgrounds'].size
    end

    test 'it should return the newest backgrounds first' do
      get backgrounds_path format: :json
      json = JSON.parse(response.body)
      
      assert_equal @background.id, json['backgrounds'].first['id']
    end

    test 'it should respond to xml requests' do
      get backgrounds_path format: :xml

      assert_response :success
      assert_equal 'application/xml', response.media_type
      assert_select 'background', {count: 10} do |element|
        assert_select 'id'
        assert_select 'url'
        assert_select 'comment'
        assert_select 'created_at'
        assert_select 'updated_at'
      end
    end
  end

  class ShowActionTest < BackgroundsTest
    test 'it should return a single background as json' do 
      get background_path @background.id, format: :json 
      json = JSON.parse(response.body)

      assert_response :success
      assert_equal 'application/json', response.media_type # this can be refactored into an assertion method
      assert_equal @background.as_json, json
    end

    test 'it should return a single background as xml' do 
      get background_path @background.id, format: :xml 

      assert_response :success
      assert_equal 'application/xml', response.media_type
      assert_select 'background', {count: 1} do |element|
        assert_select 'id'
        assert_select 'url'
        assert_select 'comment'
        assert_select 'created_at'
        assert_select 'updated_at'
      end
    end
  end
end
