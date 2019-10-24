class ContactsController < ApplicationController

  before_action :admin_required, only: [:index, :show, :destroy]
  before_action :login_required

  def index
    @contacts = Contact.all.order(created_at: "DESC")
  end

  def show
    @contact = Contact.find(params[:id])
    @user = User.find(@contact.user_id)
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "管理者にメッセージを送りました。"
      redirect_to root_path
    else
      flash.now[:danger] = "メッセージの送信に失敗しました。"
      render "new"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    if @contact.destroy
      flash[:success] = "メッセージを削除しました。"
      redirect_to "index"
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:title, :content, :user_id)
  end

end
