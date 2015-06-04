class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_photo, only: [:new, :create]
  before_action :check_owner
  @@count=0
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = @photo.comments.build
    @comment.photo=@photo
    @comment.photo_id=@photo.id
    @@count=@photo.id
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @@count=@photo.id
    @comment = Comment.new(comment_params)
    @comment.owner_id=@current_owner.id
    @comment.photo_id=@@count
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.photo, notice: 'Комментарий успешно добавлен.' }
        format.json { render :show, status: :created, location: @comment }
      else
        # @comment.photo_id=@@count
        # @photo=Photo.find(@@count)
        format.html { render :new, @comment.photo_id=>@@count}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.photo, notice: 'Комментарий успешно изменён.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    ph=@comment.photo
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to ph, notice: 'Комментарий успешно удалён.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
    def set_photo
      @photo = Photo.find(params[:comment][:photo_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:photo_id, :content, :reply, :owner_id)
    end
end
