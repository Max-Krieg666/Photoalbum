class SessionsController < ApplicationController
  def new
  end

  def create
    @owner = Owner.where(login: params[:login]).first
    if @owner && @owner.authenticate(params[:password])
      session[:owner_id] = @owner.id
      RailsWatcher::EventCreator.start(
        {
          title: 'Пользователь зашёл в систему.',
          type: 'manual',
          user_login: @owner.login
        }
      )
      redirect_to @owner, notice: 'Авторизация прошла успешно'
    else
      RailsWatcher::EventCreator.start(
        {
          title: 'Попытка входа в систему.',
          type: 'manual',
          status: 'Error',
          data: params
        }
      )
      flash[:danger] = 'Неверное имя пользователя или пароль'
      render :new
    end
  end

  def destroy
    RailsWatcher::EventCreator.start(
      {
        title: 'Пользователь вышел из систему.',
        type: 'manual',
        user_login: @current_owner.login
      }
    )
    session.delete(:owner_id)
    redirect_to login_path, notice: 'Выход выполнен'
  end
end
