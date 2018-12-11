# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user = User.all
    if @user.present?
      render json: { status: 'OK', results: @user, errors: nil }, status: :ok
    else
      render json: { status: 'FAILED', results: nil, errors: 'user not found' }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.present?
        data = @user.as_json(include: %i[pictures])
      render json: { status: 'OK', results: data, errors: nil }, status: :ok
    else
      render json: { status: 'FAILED', results: nil, errors: 'user not found' }, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { result: @user, msg: 'User succesfully created!!' }, status: :created
    else
      render json: { result: false, user: @user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { status: 'OK', results: 'Successfully deleted' }, status: :ok
    else
      render json: { status: 'FAILED', errors: @user.errors, msg: 'Cant delete user' }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    update_user = @user.update(user_params)
    if update_user
      render json: { status: 'OK', results: update_user, errors: nil }, status: :ok
    else
      render json: { status: 'FAILED', results: nil, errors: update_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name)
  end
end
