class UsersController < ApplicationController
  def index
  end

  def create
    if params[:user].nil? || params[:user][:list].nil?
      flash[:error] = "사용자 정보를 업로드 해주세요."
      redirect_to :back and return
    end
    file = params[:user][:list].tempfile.path
    begin
      list = Roo::Spreadsheet.open(file)
    rescue Exception => e
      flash[:error] = "사용자 정보 파일 업로드 실패: #{e}"
      redirect_to :back and return
    end
    redirect_to users_path
  end
end
