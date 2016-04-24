class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    if params[:users].nil? || params[:users][:list].nil?
      flash[:error] = "사용자 정보를 업로드 해주세요."
      redirect_to :back and return
    end
    sheet = Sheet.new
    sheet.sheet = params[:users][:list]
    begin
      sheet.save
      sheet.build_users_from_sheet
    rescue Exception => e
      flash[:error] = "사용자 정보 파일 업로드 실패: #{e}"
      redirect_to :back and return
    end
    redirect_to users_path
  end
end
