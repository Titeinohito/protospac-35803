class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @prototype = Prototype.find_by(params[:id])
    @comment = @prototype.comments.new(comment_params)
    @comment.save
    if @comment.save
      redirect_to controller: :prototypes, action: :show, id: @prototype.id
    else
      render template: "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
