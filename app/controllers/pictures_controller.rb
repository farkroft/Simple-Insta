class PicturesController < ApplicationController
    skip_before_action :verify_authenticity_token

  def index
    @picture = Picture.all
    if @picture.present?
      render json: { status: 'OK', results: @picture, errors: nil }, status: :ok
    else
      render json: { status: 'FAILED', results: nil, errors: 'picture not found' }, status: :unprocessable_entity
    end
  end

  def show
    @picture = Picture.find(params[:id])
    if @picture.present?
      render json: { status: 'OK', results: @picture, errors: nil }, status: :ok
    else
      render json: { status: 'FAILED', results: nil, errors: 'picture not found' }, status: :unprocessable_entity
    end
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      @picture.reload
      render json: { result: @picture.avatar, msg: 'The image succesfully uploaded!!' }, status: :created
    else
      render json: { result: false, picture: @picture.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    if @picture.destroy
      render json: { status: 'OK', results: 'Successfully deleted' }, status: :ok
    else
      render json: { status: 'FAILED', errors: @picture.errors, msg: 'Cant delete picture' }, status: :unprocessable_entity
    end
  end

  def update
    @picture = Picture.find(params[:id])
    @picture.avatar_url
    @picture.remove_avatar!
    update_picture = @picture.update(picture_params)
    if update_picture
      render json: { status: 'OK', results: update_picture, errors: nil }, status: :ok
    else
      render json: { status: 'FAILED', results: nil, errors: update_picture.errors }, status: :unprocessable_entity
    end
  end

  private

  def picture_params
    params.permit(:avatar, :user_id)
  end
end
