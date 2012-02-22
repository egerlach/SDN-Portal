class HomeController < ApplicationController
	
  def index
  	# if there's a search then it finds newsposts LIKE the search term
	@newses = params[:search] ? Newspost.where("title LIKE ?", "%#{params[:search]}%").order("created_at DESC").paginate(:page => params[:page], :per_page => 5) : Newspost.order("created_at DESC").paginate(:page => params[:page], :per_page => 5)
  
	respond_to do |format|
      format.html # index.html.erb
	  format.json
    end
  end
  
end
