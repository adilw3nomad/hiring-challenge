# frozen_string_literal: true

require 'test_helper'

class BackgroundTest < ActiveSupport::TestCase
  test 'it validates the presence of a comment' do
    background = build(:background, comment: nil)
    refute background.valid?
    assert_equal background.errors.full_messages, ['Comment can\'t be blank']
  end

  test 'it validates the presence of an image' do
    background = build(:background, :without_image)
    refute background.valid?
    assert_equal background.errors.full_messages, ['Image can\'t be blank']
  end

  test 'it validates the size of image is less then 100mb' do
    image_path = FilesHelper.file_path('rick.jpg')
    image = File.open(image_path)
    image.stubs(:size).returns(105.megabytes)
    background = build(:background, :without_image)
    background.image.attach(io: image, filename: 'rick.jpg')
    refute background.valid?
    assert_equal background.errors.full_messages, ['Image can\'t be greater than 100 megabytes']
  end

  test '#need_to_change_name? returns true if the name is one that is flagged' do
    background = build(:background, name: 'facebook')
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
