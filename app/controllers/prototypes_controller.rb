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
    Prototype.create(prototype_params)
    if Prototype.create
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)

    if @prototype.update(prototype_params)
      redirect_to action: :show
    else
      render action: :edit
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

