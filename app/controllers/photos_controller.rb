class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :update]

  def index
    @photos = Photo.order(created_at: :desc).page(params[:page])
  end

  def gallery
    @photos = Photo.visible
  end

  def show
  end

  def update
    @photo.increment(:likes_count)
    @photo.save
    redirect_to photo_path(@photo)
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
