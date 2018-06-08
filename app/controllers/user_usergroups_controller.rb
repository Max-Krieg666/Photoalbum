class UserUsergroupsController < ApplicationController
  before_action :set_user_usergroup, only: [:show, :edit, :update, :destroy]
  before_action :set_usergroup, only: :new
  before_action :check_owner

  # GET /user_usergroups
  # GET /user_usergroups.json
  def index
    @user_usergroups = UserUsergroup.all
  end

  # GET /user_usergroups/1
  # GET /user_usergroups/1.json
  def show
  end

  # GET /user_usergroups/new
  def new
    @user_usergroup = @usergroup.user_usergroups.build
    @user_usergroup.usergroup_id=@usergroup.id
  end

  # GET /user_usergroups/1/edit
  def edit
  end

  # POST /user_usergroups
  # POST /user_usergroups.json
  def create
    @user_usergroup = UserUsergroup.new(user_usergroup_params)

    respond_to do |format|
      if @user_usergroup.save
        format.html { redirect_to @user_usergroup, notice: 'Пользователь успешно добавлен в группу.' }
        format.json { render :show, status: :created, location: @user_usergroup }
      else
        format.html { render :new }
        format.json { render json: @user_usergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_usergroups/1
  # PATCH/PUT /user_usergroups/1.json
  def update
    respond_to do |format|
      if @user_usergroup.update(user_usergroup_params)
        format.html { redirect_to @user_usergroup, notice: 'Пользователь успешно изменён.' }
        format.json { render :show, status: :ok, location: @user_usergroup }
      else
        format.html { render :edit }
        format.json { render json: @user_usergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_usergroups/1
  # DELETE /user_usergroups/1.json
  def destroy
    gr=@user_usergroup.usergroup
    @user_usergroup.destroy
    respond_to do |format|
      format.html { redirect_to gr, notice: 'Пользователь успешно удалён из группы.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_usergroup
    @user_usergroup = UserUsergroup.find(params[:id])
  end
  def set_usergroup
    @usergroup = Usergroup.find(params[:usergroup_id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_usergroup_params
    params.require(:user_usergroup).permit(:usergroup_id, :user_id, :begin_date, :description)
  end
end
