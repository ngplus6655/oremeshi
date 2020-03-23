require 'rails_helper'

describe 'ログイン/ログアウト機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "佐藤諒") }

  context "ログイン機能" do
    before do
      visit root_path
    end

    context "有効なIDとパスワードを入力したとき" do
      it "テストユーザのログインに成功する" do
        fill_in 'ログインID：', with: user_a.login_id
        fill_in 'パスワード：', with: user_a.password
        click_button 'ログイン'
        expect(page).to have_css ".alert-success"
      end
    end

    context "無効なIDとパスワードを入力したとき" do
      it "テストユーザのログインに失敗する" do
        fill_in 'ログインID：', with: ""
        fill_in 'パスワード：', with: ""
        click_button 'ログイン'
        expect(page).to have_css ".alert-danger"
      end
    end
    
  end


  context "ログアウト機能" do

    before do
      visit root_path
      fill_in 'ログインID：', with: user_a.login_id
      fill_in 'パスワード：', with: user_a.password
      click_button 'ログイン'
    end

    it "正常にログアウトする" do
      click_link 'ログアウトする'
      expect(page).to have_css ".alert-info"
    end
    
  end
end
  