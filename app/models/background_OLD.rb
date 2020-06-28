# frozen_string_literal: true
# class Background < ActiveRecord::Base
#   belongs_to  :user
#   has_many    :boop_boop_asset

#   validates :name, presence: true
#   validates :image, presence: true
#   validates_size_of :image, maximum: 100.megabytes

#   after_commit :do_something, on: :create

#   def perform_processing
#     ImageProcessor.perform_async(self.id)
#   end

#   def type_string
#     "foxtrot"
#   end
# end
