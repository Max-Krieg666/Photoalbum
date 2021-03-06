class UsergroupsController < ApplicationController
  before_action :set_usergroup, only: [:show, :edit, :update, :destroy]
  before_action :check_owner

  # GET /usergroups
  # GET /usergroups.json
  def index
    @usergroups = Usergroup.includes(:user_usergroups).where(owner_id:@current_owner.id).to_a
    @count = []
    @usergroups.each do |usgr|
      us_gr = UserUsergroup.includes(:usergroup).where(usergroup_id:usgr.id).to_a
      us_gr.each do |u|
        @count = Owner.where(id: u.user_id).to_a
      end
    end
  end

  # GET /usergroups/1
  # GET /usergroups/1.json
  def show
    @count = []
    us_gr = UserUsergroup.includes(:usergroup).where(usergroup_id:@usergroup.id).to_a
    us_gr.each do |u|
      @count = Owner.where(id:u.user_id).to_a
    end
  end

  # GET /usergroups/new
  def new
    @usergroup = Usergroup.new
  end

  # GET /usergroups/1/edit
  def edit
  end

  # POST /usergroups
  # POST /usergroups.json
  def create
    @usergroup = Usergroup.new(usergroup_params)
    @usergroup.owner_id = @current_owner.id

    respond_to do |format|
      if @usergroup.save
        format.html { redirect_to @usergroup, notice: 'Группа успешно создана.' }
        format.json { render :show, status: :created, location: @usergroup }
      else
        format.html { render :new }
        format.json { render json: @usergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usergroups/1
  # PATCH/PUT /usergroups/1.json
  def update
    respond_to do |format|
      if @usergroup.update(usergroup_params)
        format.html { redirect_to @usergroup, notice: 'Группа успешно изменена.' }
        format.json { render :show, status: :ok, location: @usergroup }
      else
        format.html { render :edit }
        format.json { render json: @usergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usergroups/1
  # DELETE /usergroups/1.json
  def destroy
    @usergroup.destroy
    respond_to do |format|
      format.html { redirect_to usergroups_url, notice: 'Группа успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usergroup
      @usergroup = Usergroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usergroup_params
      params.require(:usergroup).permit(:name, :owner_id)
    end
end
