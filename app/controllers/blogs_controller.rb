class BlogsController < ApplicationController
    def index
        @blogs = Blog.all.order("id DESC")
    end

    def new
    end

    def create
        @blog = Blog.new(params.permit(:title, :content))
        if @blog.save
            flash.now[:success] = '記事を登録しました'
            @id = Blog.find_by(title: params[:title]).id
            redirect_to action: :show, id: @id
        else
            flash.now[:danger]  = '記事の登録に失敗しました'
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @blog.update(params.permit(:title, :content))
            flash.now[:succes] = '記事を編集しました'
            redirect_to action: :show, id: params[:id]
        else
            flash.now[:danger]  = '記事の登録に失敗しました'
            render :edit
        end
    end

    def destroy
        @blog.destroy
        flash.now[:success] = '記事を削除しました'
        redirect_to blogs_path   
    end
end