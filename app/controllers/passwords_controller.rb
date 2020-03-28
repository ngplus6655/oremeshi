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
    password = password_params[:password]
    password_confirmation = password_params[:password_confirmation]

    # いづれかの項目に空欄があった場合エラーを出力
    if current_password.present?
      if password.present?
        if password_confirmation.present?

          if @user.authenticate(current_password)
            if password == password_confirmation
              @user.password = password
              if @user.save
                redirect_to :account
                flash[:success] =  "パスワードを変更しました。"
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
          @user.errors.add(:password_confirmation, :empty)
          render "edit"
        end
      else
        @user.errors.add(:password, :empty)
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
