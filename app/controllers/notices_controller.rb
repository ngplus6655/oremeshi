class NoticesController < ApplicationController
  before_action :login_required
  before_action :admin_required

  def index
    @notices = Notice.all.order(:created_at, :desc)
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = Notice.new(notice_params)
    expired_day
    if @notice.save
      flash[:success] = "お知らせを設定しました。"
      redirect_to notices_path
    else
      flash.now[:danger] = "お知らせの設定に失敗しました。"
      render "new"
    end
  end

  def edit
    @notice = Notice.find(params[:id])
  end

  def update
    @notice = Notice.find(params[:id])
    @notice.assign_attributes(notice_params)
    expired_day
    if @notice.save
      flash[:success] = "お知らせを編集しました。"
      redirect_to notices_path
    else
      flash.now[:danger] = "お知らせの編集に失敗しました。"
      render "new"
    end
  end

  def destroy
    @notice = Notice.find(params[:id])
    if @notice.destroy
      flash[:success] = "お知らせを削除しました。"
      redirect_to notices_path
    end
  end

  private

  def notice_params
    params.require(:notice).permit(:content, :released_at, :expired_at)
  end

  def expired_day
    if notice_params[:expired_at] == "0"
      @notice.expired_at = nil
    else
      weeks = notice_params[:expired_at].to_i
      weeks = weeks * 7
      @notice.expired_at = @notice.released_at + weeks
    end
  end

end
