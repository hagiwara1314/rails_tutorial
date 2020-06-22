class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_search, unless: :devise_controller?

    protect_from_forgery

      
    protected

    def configure_permitted_parameters
      added_attrs = [:email, :username, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    def set_search
      if params[:q] != nil
        params[:q]['title_or_content_or_create_user_cont_all'] = params[:q]['title_or_content_or_create_user_cont_all'].split(/[\p{blank}\s]+/)
      end
      @search = Blog.ransack(params[:q])
      @result = @search.result(distinct: true).page(params[:page]).per(10)
    end
  end
