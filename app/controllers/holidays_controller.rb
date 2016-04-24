class HolidaysController < ApplicationController
  def index
    @holidays = NationalHoliday.all
  end

  def create
    if params[:holidays].nil? || params[:holidays][:list].nil?
      flash[:error] = "휴일 정보를 업로드 해주세요."
      redirect_to :back and return
    end
    sheet = Sheet.new
    sheet.sheet = params[:holidays][:list]
    begin
      sheet.save
      list = sheet.build_holidays_from_sheet
    rescue Exception => e
      flash[:error] = "휴일 정보 파일 업로드 실패: #{e}"
      redirect_to :back and return
    end
    redirect_to holidays_path
  end
end
