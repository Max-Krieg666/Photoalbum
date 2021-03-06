class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_album, only: :new
  before_action :check_owner
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @x = UsergroupsAccess.includes(:photo).where(photo_id: @photo.id).to_a
    @xxx = TableOfAssesment.where(owner_id:@current_owner.id,photo_id:@photo.id).to_a
    @comments = Comment.where(photo_id: @photo.id).order(:created_at).to_a
    users_access_decline = []
    if @x.size != 0
      @x.each do |elem|
        Usergroup.where(id: elem.usergroup_id).to_a.first.user_usergroups.each do |el|
          users_access_decline << Owner.find_by_id el.user_id
        end
      end
    end
    if users_access_decline.size != 0
      users_access_decline.each do |us|
        if @current_owner == us
          flash[:danger] = "Пользователь < #{@photo.album.owner} > ограничил доступ к этой фотографии для Вас!"
          redirect_to @photo.album
        end
      end
    end
  end

  # GET /photos/new
  def new
    @photo = @album.photos.build
    @photo.album = @album
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @first = 0
    @album = Album.find(@photo.album_id)
    if params[:photo][:image].blank?
      flash[:danger] = "При сохранении произошла ошибка! Необходимо загрузить хотя бы одну фотографию!"
      render :new
    else
      params[:photo][:image].each do |upload|
        @photo = Photo.new(photo_params)
        @photo.num_of_assessments=0
        @photo.sum_of_assessments=0
        @photo.average_rating=0.0
        @photo.rate=0
        @photo.image=upload
        if @photo.album.photos.size==0
          @photo.position=@photo.id
          @first=@photo
        end
        if !@photo.save
          render :new
        end
      end
      if @first!=0
        @album.cover=@first.id
        @album.save!
      end
      if @photo.position==1
        @photo.position=@photo.id
        @album.cover=@photo.id
        @album.save!
        @photo.save
      else
        @photo.position=0
      end
      redirect_to @photo.album, notice: 'Фотографии загружены.'
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update

    respond_to do |format|
      if @photo.update(photo_params)
        if @photo.rate!=0
          @photo.sum_of_assessments+=@photo.rate
          @photo.num_of_assessments+=1
          @photo.average_rating=@photo.sum_of_assessments.to_f/@photo.num_of_assessments.to_f
          TableOfAssesment.create(owner_id: @current_owner.id, rate: @photo.rate, photo_id:@photo.id)
          @photo.rate=0
          @photo.save
        end
        if @photo.position!=0
          @album=@photo.album
          if Photo.where(id: @album.cover).load.map{|x| x}.size>0
            p1=Photo.where(id: @album.cover).load.map{|x| x}[0]
            p1.position=0
            p1.save
          end
          @album.cover=@photo.id
          @album.save!
        end
        format.html { redirect_to @photo, notice: 'Фотография успешно изменена.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    alb=@photo.album
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to alb, notice: 'Фотография успешно удалена.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end
    def set_album
      @album = Album.find(params[:album_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:album_id, :title, :creation_date, :description, :image, :position, :rate)
    end
end
