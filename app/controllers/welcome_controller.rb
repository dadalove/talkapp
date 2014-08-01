class WelcomeController < ApplicationController

def index
  @comments=Comment.includes(:user).all                   #includes關聯user物件  檢視全部使用者的所有留言

end








end
