class BlogsController < ApplicationController
    def index
        if params[:search_type] == 'date'
            redirect_to action: :search
        else
            @blogs = @result.order("id DESC")
        end
    end

    def new
        @username = current_user.username
    end

    def create
        @blog = Blog.new(params.permit(:title, :content, :create_user))
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

    def search
        if params[:search_type] == 'date'
            if params[:target_column] == ''
                params[:q] = {
                    'created_at_or_updated_at_gteq' => params[:from],
                    'created_at_or_updated_at_lteq' => params[:to]
                }
            elsif params[:target_column] == 'created_at'
                params[:q] = {
                    'created_at_gteq' => params[:from],
                    'created_at_lteq' => params[:to]
                }
            elsif params[:target_column] == 'updated_at'
                params[:q] = {
                    'updated_at_gteq' => params[:from],
                    'updated_at_lteq' => params[:to]
                }
            end
        end
        @SearchDate = Blog.ransack(params[:q])
        @ResultDate = @SearchDate.result(distinct: true).order("id DESC").page(params[:page]).per(10)
    end
end