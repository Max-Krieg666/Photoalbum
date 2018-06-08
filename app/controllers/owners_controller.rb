class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]
  before_action :choose, except: [:new, :create, :index]

  # GET /owners
  # GET /owners.json
  def index
    @owners = Owner.all
  end

  # GET /owners/1
  # GET /owners/1.json
  def show
    @albums = Album.where(owner_id: @owner.id)
  end

  # GET /owners/new
  def new
    @owner = Owner.new
  end

  # GET /owners/1/edit
  def edit
  end

  # POST /owners
  # POST /owners.json
  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      @owner.authenticate(params[:password])
      session[:owner_id] = @owner.id
      redirect_to @owner, notice: 'Вы успешно зарегестрированы.'
    else
      render :new
    end
  end

  # PATCH/PUT /owners/1
  # PATCH/PUT /owners/1.json
  def update
    respond_to do |format|
      if @owner.update(owner_params)
        format.html { redirect_to @owner, notice: 'Пользователь изменен.' }
        format.json { render :show, status: :ok, location: @owner }
      else
        format.html { render :edit }
        format.json { render json: @owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /owners/1
  # DELETE /owners/1.json
  def destroy
    @owner.destroy
    respond_to do |format|
      format.html { redirect_to owners_url, notice: 'Пользователь удален.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_owner
    @owner = Owner.find(params[:id])
  end
  def choose
    if @current_owner.id != @owner.id && !@current_owner.administrator?
      flash[:danger] = 'Доступ запрещён!'
      redirect_to albums_path
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def owner_params
    params.require(:owner).permit(
      :login, :password, :avatar,
      :password_confirmation,
      :residence, :sex, :birthday, :mail
    )
  end
end
