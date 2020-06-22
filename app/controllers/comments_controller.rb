class CommentsController < ApplicationController
    def create
      @comment = Comment.new(params.permit(:content, :user_id, :blog_id))
      if @comment.save
        redirect_back(fallback_location: root_path)
      else
        flash.now[:danger]  = 'コメントの登録に失敗しました'
        redirect_back(fallback_location: root_path)
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_back(fallback_location: root_path)
    end
  end
