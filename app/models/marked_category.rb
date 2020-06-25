class MarkedCategory < ApplicationRecord
      has_many :backgrounds

  def get_backgrounds
    return self.backgrounds
  end
end
