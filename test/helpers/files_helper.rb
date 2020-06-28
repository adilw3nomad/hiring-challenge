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

  private

  def upload(name, type)
    file_path = Rails.root.join('test', 'fixtures', 'files', name)
    fixture_file_upload(file_path, type)
  end
end
