class DashboardsController < ApplicationController 
  
  def index
    @athleties = User.paginate(page: params[:page])
  end
end
