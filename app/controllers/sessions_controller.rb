class SessionsController < ApplicationController

  def new
  end

  def create
    @owner=Owner.where(login: params[:login]).first
    if @owner && @owner.authenticate(params[:password])
      session[:owner_id]=@owner.id
      redirect_to @owner, notice: 'Авторизация прошла успешно'
    else
      flash[:danger]='Неверное имя пользователя или пароль'
      render :new
    end
  end

  def destroy
    session.delete(:owner_id)
    redirect_to login_path, notice: 'Выход выполнен'
  end
end
