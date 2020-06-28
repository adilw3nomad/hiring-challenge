class Background < ActiveRecord::Base
  # Flagged names are names which we need to change for copyright reasons
  FLAGGED_NAMES = %w[facebook twitter tiktok].freeze

  has_one_attached :image

  validates :comment, presence: true
  validates :image, presence: true

  before_create :change_name if :need_to_change_name?

  def need_to_change_name?
    FLAGGED_NAMES.include?(name)
  end

  def change_name
    self.name = Faker::Games::Dota.hero
  end
end
