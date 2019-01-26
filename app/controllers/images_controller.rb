class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:url, :tag_list))

    if @image.save
      flash[:success] = 'You have successfully added an image.'
      redirect_to image_path(@image)

    else
      flash.now[:danger] = 'The action could not be completed'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:danger] = 'The page does not exist'
  end

  def index
    if params[:tag]
      flash.now[:danger] = 'The tag does not exist' if Image.tagged_with(params[:tag]).empty?
      @images = Image.tagged_with(params[:tag]).order('created_at Desc')
    else
      @images = Image.all.order('created_at Desc')
    end
  end

  def destroy
  begin
    @image = Image.find(params[:id])
    @image.destroy
  rescue ActiveRecord::RecordNotFound
  end
    flash[:success] = 'You have successfully deleted an image.'
    redirect_to images_path
  end
end
