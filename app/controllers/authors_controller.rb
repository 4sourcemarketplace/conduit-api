class AuthorsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index

    @authors = Author.all.includes(:user)
    @authors = @authors.tagged_with(params[:tag]) if params[:tag].present?
    @authors = @authors.authored_by(params[:author]) if params[:author].present?
    @authors = @authors.favorited_by(params[:favorited]) if params[:favorited].present?

    @authors_count = @authors.count

    @authors = @authors.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  def new
  end

  def feed
    @all = Author.all
    if @all.length  > 1
    @authors = Author.includes(:user).where(user: current_user.following_users)
    @authors_count = @authors.count
    @authors = @authors.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
    end
    render :index
  end

  def create
    @Author = Author.new(Author_params)
    @Author.user = current_user

    if @Author.save
      render :show
    else
      render json: { errors: @Author.errors }, status: :unprocessable_entity
    end
  end

  def show
    @Author = Author.find_by!(id: params[:id])
  end

  def update
    @Author = Author.find_by!(id: params[:id])

    if @Author.user_id == @current_user_id
      @Author.update_attributes(Author_params)

      render :show
    else
      render json: { errors: { Author: ['not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    @Author = Author.find_by!(id: params[:id])

    if @Author.user_id == @current_user_id
      @Author.destroy

      render json: {}
    else
      render json: { errors: { Author: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def Author_params
    params.require(:author).permit(:name,:user_id,:article_id)
  end
end
