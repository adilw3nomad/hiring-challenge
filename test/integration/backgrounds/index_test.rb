# frozen_string_literal: true

require 'test_helper'

module Backgrounds
  class IndexActionTest < ActionDispatch::IntegrationTest
    setup do
      9.times { create(:background, created_at: 2.days.ago) }
      @background = create(:background, created_at: 5.minutes.ago)
    end

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
end
