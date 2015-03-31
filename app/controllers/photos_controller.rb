class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
  	@photos = current_user.photos #Rails will do the logic to show the photos of the logged in user
  end

  def new
  	@photo = Photo.new
  end

  def create
  	@photo = Photo.new(photo_params)
    @photo.user = current_user

    # @photos = current_user.photos.build(photo_params)

  	if @photo.save 
  		redirect_to photos_path
  	else
  		render :new
  end
 end 

 def edit
  @photo = current_user.photos.find(params[:id])
 end

 def update
  @photo = current_user.photos.find(params[:id])

  if @photo.update_attributes(photo_params)
    redirect_to photos_path
  else
    render :edit
  end
 end

private

  def photo_params
  	params.require(:photo).permit(:filename, :caption)
  end
end

