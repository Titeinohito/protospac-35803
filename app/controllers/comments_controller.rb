class CommentsController < ApplicationController

  def index
    @comment = Comment.new
    @prototype = Prototype.find(params[:prototype_id])
  end

  def new
    @comment = Comment.new
  end

  def create
    #@prototype = Prototype.new
    #binding.pry
    #@prototype = Prototype.find(params[:prototype_id])
    #@comment = @prototype.comments.new(comment_params)
    #binding.pry
    #@comment.save
    Comment.create(comment_params)
    #binding.pry
    if Comment.create
      redirect_to controller: :prototypes, action: :show, id: params[:prototype_id]
    else
      render template: "prototypes/show"
    end
  end

  private

  def comment_params
    #binding.pry
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
