# frozen_string_literal: true

require 'test_helper'

class BackgroundsTest < ActionDispatch::IntegrationTest
  setup do
    9.times { create(:background, created_at: 2.days.ago) }
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
      assert_select 'background', { count: 10 } do
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
      assert_select 'background', { count: 1 } do
        assert_select 'id'
        assert_select 'url'
        assert_select 'comment'
        assert_select 'created_at'
        assert_select 'updated_at'
      end
    end
  end

  class CreateActionTest < BackgroundsTest
    test 'it creates a background if params are valid' do
      assert_changes 'Background.count', from: 10, to: 11 do
        post '/backgrounds', params: {
          background: {
            name: 'Mountain Range', url: 'https://imgur.com/n1ge', comment: 'A mountain range', image: FilesHelper.jpg
          }
        }
        assert_response :created
      end
    end

    test 'it does not create a background if params are missing' do
      assert_no_changes 'Background.count' do
        post '/backgrounds', params: {
          background: {
            name: 'Mountain Range', url: 'https://imgur.com/n1ge', image: FilesHelper.jpg
          }
        }
      end
      resp = JSON.parse(response.body)
      assert_equal resp['errors'], ['Comment can\'t be blank']
      assert_response :unprocessable_entity
    end

    test 'it changes the name of the background before saving if it is flagged' do
      post '/backgrounds', params: {
        background: {
          name: 'facebook', url: 'https://imgur.com/facebook', comment: 'A mountain range',
          image: FilesHelper.jpg
        }
      }
      refute Background.last.name == 'facebook'
      assert_equal Background.last.url, 'https://imgur.com/facebook'
    end
  end

  class UpdateActionTest < BackgroundsTest
    test 'it updates a background' do
      patch "/backgrounds/#{@background.id}", params: {
        background: {
          comment: 'Lets get schwifty!'
        }
      }
      assert_response :success
      assert_equal @background.reload.comment, 'Lets get schwifty!'
    end

    test 'it does not update background if params are invalid' do
      assert_no_changes '@background.comment' do
        patch "/backgrounds/#{@background.id}", params: {
          background: {
            comment: nil
          }
        }
        resp = JSON.parse(response.body)
        assert_equal resp['errors'], ['Comment can\'t be blank']
        assert_response :unprocessable_entity
      end
    end
  end
end
