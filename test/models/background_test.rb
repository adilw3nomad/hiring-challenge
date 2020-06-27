# frozen_string_literal: true

require 'test_helper'

class BackgroundTest < ActiveSupport::TestCase
  test 'it validates the presence of a comment on creation' do
    background = build(:background, comment: nil)
    refute background.valid?
  end

  test '#need_to_change_name? returns true if the name is one that is flagged' do
    background = create(:background, name: 'facebook')
    assert background.need_to_change_name?
  end

  test '#need_to_change_name? returns false if the name is not flagged' do
    background = create(:background)
    refute background.need_to_change_name?
  end

  test 'it renames backgrounds if there name is flagged' do
    background = build(:background, name: 'facebook')
    assert_equal background.name, 'facebook'
    background.save
    refute background.name == 'facebook'
  end
end
