class CommentsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :user_exists?
  # POST /comments
  # POST /comments.json
  def create
	curr_user = current_user
	if curr_user
		@comment = Comment.new(params[:comment])
		
		if Newspost.find(@comment.newspost_id)
			@comment.user_id = curr_user.id
		end
	
		respond_to do |format|
			if @comment.save
				format.html { redirect_to newspost_path(@comment.newspost_id), notice: 'Comment was successfully created.' }
			else
				format.html { redirect_to newspost_path(@comment.newspost_id), notice: 'Comment was errored.' }
			end
		end
	else
		redirect_to newspost_path(newspost)
	end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
	curr_user = current_user
	comment = Comment.find(params[:id])
	if curr_user.id == comment.user_id || curr_user.admin
		@comment = comment
		@comment.destroy

		respond_to do |format|
		  format.html { redirect_to newspost_path(comment.newspost_id) }
		end
	else
		redirect_to newspost_path(comment.newspost_id)
	end
  end
end
