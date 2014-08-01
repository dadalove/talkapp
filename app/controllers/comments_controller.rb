class CommentsController < ApplicationController

before_action :authenticate_user!, only:[:new,:create,:destroy]       #會員才能使用new、create、destroy的功能

def index
  @user=User.find(params[:user_id])
  @comments=@user.comments                           #顯示使用者的所有留言
end

def new
  @comment=Comment.new                               #新增留言
end

def create
  @comment=Comment.new(comment_params)
  @comment.user = current_user                       #留言的使用者就是現在登入的人
  if @comment.save
    redirect_to root_path
  else
    render :new
  end
end

def show
  @comment=Comment.find(params[:id])
end


def destroy
  @comment=Comment.find(params[:id])                  #取得一筆留言資料
  if @comment.user==current_user                      #留言的人是不是現在登入的人?
    @comment.destroy                                  #是的話就可以刪除留言
    redirect_to root_path
  else                                                #不是該使用者，就不能刪留言
    redirect_to root_path                                             
  end
end







private

def comment_params
  params.require(:comment).permit(:content)          #permit裡面不需要有user_id，因為form裡面沒有 
end

end
