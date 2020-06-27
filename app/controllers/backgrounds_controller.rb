# Processes the image backgrounds for use on screens
class BackgroundsController < ApplicationController
  before_action :find_background, only: [:show, :update]

  def index
    @backgrounds = Background.order('created_at DESC')
    respond_to do |format|
      format.json { render json: { backgrounds: @backgrounds } }
      format.xml
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @background }
      format.xml
    end
  end

  def create
    background = Background.new(background_params)
    if background.save
      render json: background, status: :created
    else
      render json: {
        errors: background.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @background.update(background_params)
      render json: @background
    else
      render json: {
        errors: @background.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  protected

  def background_params
    params.require(:background).permit(:comment, :url, :name)
  end

  def find_background
    @background ||= Background.find(params[:id])
  end
end
