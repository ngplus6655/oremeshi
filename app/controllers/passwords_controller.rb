class PasswordsController < ApplicationController
  before_action :login_required

  def show
    redirect_to :account
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    current_password = password_params[:current_password]
    if current_password.present?
      if @user.authenticate(current_password)
        if password_params[:password] == password_params[:password_confirmation]
          @user.password = password_params[:password]
          if @user.save
            redirect_to :account
            flash[:info] =  "パスワードを変更しました。"
          else
            render "edit"
          end
        else
          @user.errors.add(:password_confirmation, :mismatching)
          render "edit"
        end
      else
        @user.errors.add(:current_password, :wrong)
        render "edit"
      end
    else
      @user.errors.add(:current_password, :empty)
      render "edit"
    end
  end

  private

    def password_params
      params.require(:password).permit([:current_password, :password, :password_confirmation])
    end
end
