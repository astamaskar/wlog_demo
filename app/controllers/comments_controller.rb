class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post

	def create
		@comment = @post.comments.create(comments_params)
		@comment.user = current_user

		if @comment.save
			flash[:notice] = 'Comment has been created.'
			redirect_to post_path(@post)
		else
			flash[:alert] = 'Comment has not been created.'
			redirect_to post_path(@post)
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end 

	private

	def set_post
		@post = Post.find(params[:post_id])
	end

	def comments_params
		params.require(:comment).permit(:body)
	end

end
