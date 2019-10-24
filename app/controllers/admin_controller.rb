class AdminController < ApplicationController

  before_action :login_required
  before_action :admin_required
  
  def dashboard
  end
end
