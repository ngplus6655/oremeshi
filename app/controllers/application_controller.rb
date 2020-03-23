class ApplicationController < ActionController::Base

  before_action :notices

  private 
  
  def current_user
    User.find_by( login_id: session[:login_id] ) if session[:login_id] 
  end
  helper_method :current_user


  def login_required
    if current_user.nil?
      flash["info"] = "サイドバー(スマホの方はこのページの下)のフォームからログインすることで利用できます。"
      redirect_to :root
    end
  end

  def admin_required
    if current_user.nil? || !current_user.admin?
      flash["danger"] = "権限がありません。"
      redirect_to :root
    end
  end

  def notices
    date_now = Date.current
    @notices_side = Notice.where(['released_at <= :date AND expired_at >= :date OR expired_at IS NULL',
     date: date_now] )
  end


end
