# frozen_string_literal: true

module FilesHelper
  extend self
  extend ActionDispatch::TestProcess

  def jpg_name
    'rick.jpg'
  end

  def jpg
    upload(jpg_name, 'image/jpg')
  end

  def file_path(name)
    Rails.root.join('test', 'fixtures', 'files', name)
  end

  private

  def upload(name, type)
    fixture_file_upload(file_path(name), type)
  end
end
