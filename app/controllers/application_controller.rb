class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  before_filter :launch_workers

  @@running_workers = false

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'current' : ''
  end
  private
    def launch_workers
      WorkerLauncher.launch_workers unless @@running_workers
      @@running_workers = true
    end
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

end
