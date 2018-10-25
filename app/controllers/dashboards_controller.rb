class DashboardsController < ApplicationController 
  
  def index
    @athleties = User.all
  end
end
