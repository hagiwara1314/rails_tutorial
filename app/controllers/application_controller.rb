class ApplicationController < ActionController::Base
    protect_from_forgery
    before_action :blog_data, only[:show, :edit, ;update, :destroy]
    
    private
    def blog_data
        @blog = Blog.find(params[:id])
    end
end
