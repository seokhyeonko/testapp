class LoginController < ApplicationController
    layout 'login_head'
    
    def write
       
        @mail = params[:email]
        @password_regist = params[:password_regist]
        @name_regist = params[:username_regist]
    
    end
end