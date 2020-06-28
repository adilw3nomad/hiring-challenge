# frozen_string_literal: true

require 'test_helper'

module Backgrounds
  class ShowActionTest < ActionDispatch::IntegrationTest
    setup do
      @background = create(:background, created_at: 5.minutes.ago)
    end

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
end
