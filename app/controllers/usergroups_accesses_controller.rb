class UsergroupsAccessesController < ApplicationController
  before_action :set_usergroups_access, only: [:show, :edit, :update, :destroy]
  before_action :set_photo, only: [:new, :index]
  before_action :check_owner

  # GET /usergroups_accesses
  # GET /usergroups_accesses.json
  def index
    @usergroups_accesses = UsergroupsAccess.where(photo_id: @photo.id)
    @old_photo=@photo
  end

  # GET /usergroups_accesses/1
  # GET /usergroups_accesses/1.json
  def show
  end

  # GET /usergroups_accesses/new
  def new
    @usergroups_access = @photo.usergroups_accesses.build
    @usergroups_access.photo_id=@photo.id
  end

  # GET /usergroups_accesses/1/edit
  def edit
  end

  # POST /usergroups_accesses
  # POST /usergroups_accesses.json
  def create
    @usergroups_access = UsergroupsAccess.new(usergroups_access_params)

    respond_to do |format|
      if @usergroups_access.save
        format.html { redirect_to Photo.find(@usergroups_access.photo_id), notice: 'Настройки доступа установлены.' }
        format.json { render :show, status: :created, location: @usergroups_access }
      else
        format.html { render :new }
        format.json { render json: @usergroups_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usergroups_accesses/1
  # PATCH/PUT /usergroups_accesses/1.json
  def update
    respond_to do |format|
      if @usergroups_access.update(usergroups_access_params)
        format.html { redirect_to @usergroups_access, notice: 'Настройки доступа изменены.' }
        format.json { render :show, status: :ok, location: @usergroups_access }
      else
        format.html { render :edit }
        format.json { render json: @usergroups_access.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usergroups_accesses/1
  # DELETE /usergroups_accesses/1.json
  def destroy
    ph=@usergroups_access.photo_id
    @usergroups_access.destroy
    respond_to do |format|
      format.html { redirect_to action: 'index', photo_id: ph, notice: 'Настройки доступа удалены.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usergroups_access
      @usergroups_access = UsergroupsAccess.find(params[:id])
    end

    def set_photo
      @photo = Photo.find(params[:photo_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usergroups_access_params
      params.require(:usergroups_access).permit(:photo_id, :usergroup_id, :access)
    end
end
