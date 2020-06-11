class BlogsController < ApplicationController
  def index
      @blogs = Blog.all.order("id DESC")
  end

  def new
  end

  def create
      params[:id] = Blog.maximum(:id)+1
      @blog = Blog.new(params.permit(:title, :content, :id))
      @titles = Blog.find_by(title: params[:title])
      if @titles != nil
          flash.now[:danger]  = '過去の記事とタイトルが重複しています'
          render :new

      elsif @blog.save
          flash.now[:success] = '記事を登録しました'
          redirect_to action: :show, id: params[:id]

      else
          flash.now[:danger]  = '記事の登録に失敗しました'
          render :new
      end
  end

  def show
      @article = Blog.find(params[:id])
  end

  def edit
      @blog = Blog.find(params[:id])
  end

  def update
      @blog = Blog.find(params[:id])
      @titles = Blog.find_by(title: params[:title])
      if @titles != nil && params[:title] != Blog.find(params[:id]).title
          flash.now[:danger]  = '過去の記事とタイトルが重複しています'
          render :edit
      
      elsif @blog.update(params.permit(:title, :content))
          flash.now[:succes] = '記事を編集しました'
          redirect_to action: :show, id: params[:id]

      else
          flash.now[:danger]  = '記事の登録に失敗しました'
          render :edit
      end
  end

  def destroy
      @blog = Blog.find(params[:id])
      @blog.destroy
      flash.now[:success] = '記事を削除しました'
      redirect_to blogs_path   
  end
end