class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :check_owner

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
    @album.owner = @current_owner
    @album.owner_id = @current_owner.id
    if @album.creation_date.blank?
      @album.creation_date=Date.current#new(year: Time.now.year,day: Time.now.day,month: Time.now.month)
    end
    @album.cover=nil
    if @album.save
      redirect_to @album, notice: 'Альбом успешно создан.'
    else
      render :new
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    if @album.update(album_params)
      redirect_to @album, notice: 'Альбом успешно изменён.'
    else
      render :edit
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    redirect_to albums_url, notice: 'Альбом успешно удалён.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:name, :creation_date, :cover)
    end
end
