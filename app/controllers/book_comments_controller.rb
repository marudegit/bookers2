class BookCommentsController < ApplicationController

  before_action :is_matching_login_user, only: [:destroy]
  def create
    book = Book.find(params[:book_id])
    book_comment = current_user.book_comments.new(book_comments_params)
    book_comment.book_id = book.id
    book_comment.save
    redirect_to request.referer
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    redirect_to request.referer
  end

  private
  def book_comments_params
    params.require(:book_comment).permit(:comment)
  end

  def is_matching_login_user
    user = BookComment.find(params[:id]).user
    unless user.id == current_user.id
      redirect_to request.referer
    end
  end
end
