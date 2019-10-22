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
    current_password = params[:account][:current_password]
    if current_password.present?
      if @user.authenticate(current_password)
        if params[:account][:password] == params[:account][:password_confirmation]
          @user.password = params[:account][:password]
          if @user.save
            redirect_to :account, notice: "パスワードを変更しました。"
          else
            render "edit"
          end
        else
          @user.errors.add(:password_confirmation, :mismatching)
        end
      else
        @user.errors.add(:current_password, :wrong)
      end
    else
      @user.errors.add(:current_password, :empty)
      render "edit"
    end
  end
end
