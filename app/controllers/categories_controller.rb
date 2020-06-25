# Puts the backgrounds into categories
class CategoriesController < ApplicationController
  def index
    render json: {
      categories: MarkedCategory.all
    }
  end

  def show
    category = find_category(params[:id])

    render json: category.to_json
  end

  def create
    category = MarkedCategory.create(params.require(:category).permit!)

    result = category.save

    if result == true
      return category.to_json()
    else
      render json: {
        errrors: category.errors.full_messages
      }
    end
  end

  def update
  end
      
  def find_category(background_id)
    # [TEST-GUIDANCE]: not expecting scoping by user/account here, assume categories are public resource
    return MarkedCategory.where(id: background_id).first()
  end
end
