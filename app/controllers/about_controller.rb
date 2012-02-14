class AboutController < ApplicationController
  before_filter :is_admin?, :only => [ :edit, :update ]
  def index
  	@about = Page.where(:name => "About").first
  end

  def edit
  	@about = Page.find(params[:id])
  end

end
