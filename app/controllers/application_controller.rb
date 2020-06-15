class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery
    before_action :blog_data, unless: :devise_controller?, only:[:show, :edit, :update, :destroy]
    
    private
    def blog_data
      @blog = Blog.find(params[:id])
    end
      
    protected

    def configure_permitted_parameters
      added_attrs = [:email, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
