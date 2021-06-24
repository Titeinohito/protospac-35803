class PrototypesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:prototype)
  end

  def create
    @user = User.find_by(params[:id])
    binding.pry
    @prototype = @user.prototypes.new(prototype_params)
    @prototype.save
    if @prototype.save
      redirect_to action: :index
    else
      render new_prototype_path
    end
  end

  def edit
    unless user_signed_in?
      redirect_to action: :index
    end
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    binding.pry
    @prototype.update(prototype_params)

    if @prototype.update(prototype_params)
      redirect_to action: :show
    else
      render edit_prototype_path
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image,).merge(user_id: current_user.id)
  end
end

