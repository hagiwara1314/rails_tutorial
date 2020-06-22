class CommentsController < ApplicationController
    def create
      @comment = Comment.new(params.require(:comment).permit(:content, :blog_id))
      @comment.user_id = current_user.id
      if @comment.save
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
      end
  
    end
  end
