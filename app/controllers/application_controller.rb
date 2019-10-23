class ApplicationController < ActionController::Base

  private 
  
  def current_user
    User.find_by( login_id: cookies.signed[:user_login_id] ) if cookies.signed[:user_login_id] 
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


end
