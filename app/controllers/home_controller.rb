class HomeController < ApplicationController
  def index
    render :index, layout: "application_external"
  end

  def about
  end

end
