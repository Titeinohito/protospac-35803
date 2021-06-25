class CommentsController < ApplicationController

  def index
    @comment = Comment.new
    @prototype = Prototype.find(params[:prototype_id])
  end

  def new
    @comment = Comment.new
  end

  def create
    Comment.create(comment_params)
    if Comment.create
      redirect_to controller: :prototypes, action: :show, id: params[:prototype_id]
    else
      render template: "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
