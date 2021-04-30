class ApplicationController < ActionController::Base
  before_action :set_categories
  
  def set_categories
    @categories = Category.order(:name)
  end
end
