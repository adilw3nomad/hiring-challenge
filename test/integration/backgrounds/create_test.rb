# frozen_string_literal: true

require 'test_helper'

module Backgrounds
  class CreateActionTest < ActionDispatch::IntegrationTest
    test 'it creates a background if params are valid' do
      assert_changes 'Background.count', from: 0, to: 1 do
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
end
