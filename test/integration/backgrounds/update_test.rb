# frozen_string_literal: true

require 'test_helper'

module Backgrounds
  class UpdateActionTest < ShowActionTest
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
