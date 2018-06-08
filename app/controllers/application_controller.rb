class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_current_owner
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protect_from_forgery with: :exception

  private

  def record_not_found
    render plain: '404 Not Found', status: 404
  end

  def set_current_owner
    if session[:owner_id].present?
      @current_owner = Owner.find(session[:owner_id])
    end
  end

  def require_login
    if @current_owner
      flash[:danger] = 'Требуется авторизация'
      redirect_to login_path
    end
  end

  def check_owner
    if @current_owner.blank?
      flash[:danger] = "Необходимо войти в систему для просмотра данной страницы!"
      redirect_to root_path
    end
  end

  def manager_permission
    unless @current_owner.try(:manager?)
      flash[:danger] = 'Недостаточно прав'
      redirect_to login_path
    end
  end

  def admin_permission
    unless @current_owner.try(:administrator?)
      flash[:danger] = 'Недостаточно прав'
      redirect_to login_path
    end
  end
end
