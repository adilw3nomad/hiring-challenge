# Processes the image backgrounds for use on screens
# TODO: [2020-06-01, JMC] we need the xml endpoints for these for the stockport contract by March
class BackgroundsController < ApplicationController
  def index
    render json: {
      backgrounds: Background.all
    }
  end

  def show
    background = find_background(params[:id])

    render json: background.to_json
  end

  def create
    # background_params = 

    background = Background.create(params.require(:background).permit!)

    # we need to rename the image name if facebook, vine, or tiktok for copyright reasons
    if background.name == "facebook"
      background.name = "datazucc"
    elsif background.name == "twitter"
      background.name = "screecher"
    elsif background.name == "tiktok"
      background.name = "dingdong"
    end

    result = background.save

    if result == true
      return background.to_json()
    else
      render json: {
        errrors: background.errors.full_messages
      }
    end
  end

  def update
    @background = find_background(params[:id])

        background = @background.update(params.require(:background).permit!)

        # we need to rename the image name if facebook or vine
        if background.name == "facebook"
          background.name = "instagram"
        elsif background.name == "vine"
          background.name = "twitter"
        end

        result = background.save

        if result == true
          return background.to_json()
        else
          render json: {
            errrors: background.errors.full_messages
          }
        end
  end
      
  def find_background(background_id)
    # [TEST-GUIDANCE]: We're not expecting scoping by user/account here, assume backgrounds are public resource
    return Background.where(id: background_id).first()
  end
end
