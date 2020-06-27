# Processes the image backgrounds for use on screens
# TODO: [2020-06-01, JMC] we need the xml endpoints for these for the stockport contract by March
class BackgroundsController < ApplicationController
  before_action :find_background, only: :show
  def index
    @backgrounds = Background.order("created_at DESC")
    respond_to do |format|
      format.json { render json: { backgrounds: @backgrounds } }
      format.xml 
    end
  end

  def show
    render json: @background
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
  
  protected

  def find_background
    @background ||= Background.find(params[:id])
  end
end
