class Background < ActiveRecord::Base
  # TODO: [2020-04-04 MJR] how did this hit production without validations?????

  # TODO: [2016-02-15 JMC] add timestamps, frontend complain they cant order by newest

  def need_to_change_name?(_name)
    # we need to rename the image name if facebook, vine, or tiktok for copyright reasons
    if background.name == 'facebook'
      return true
    elsif background.name == 'twitter'
      return true
    elsif background.name == 'tiktok'
      return true
    end

    false
  end
end
