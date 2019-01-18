class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params.require(:image).permit(:url, :tag_list))

    if @image.save
      redirect_to image_path(@image)

    else
      flash.now[:danger] = 'The action could not be completed'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:error] = 'The page does not exist'
  end

  def index
    @images = Image.all.order('created_at Desc')
  end
end
