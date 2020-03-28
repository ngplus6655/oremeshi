require 'rails_helper'

describe 'パスワード再設定機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: "佐藤諒") }

  before do
    login(user_a)
    click_link "マイページ"
    click_link "パスワードの再設定"
  end

  context "現在のパスワードの値を間違う" do
    before do
      fill_in "現在のパスワード", with: "" 
      fill_in "新しいパスワード", with: "pass"
      fill_in "新しいパスワード(確認)", with: "pass"
      click_button "変更"
    end

    it "変更に失敗する" do
      expect(page).to have_content "現在のパスワードを入力してください"
    end
  end

  context "無効なパスワードを入力する" do
    before do
      fill_in "現在のパスワード", with: "password" 
      fill_in "新しいパスワード", with: ""
      fill_in "新しいパスワード(確認)", with: ""
      click_button "変更"
    end

    it "変更に失敗する" do
      expect(page).to have_content "新しいパスワードを入力してください"
    end
  end 

  context "確認用パスワードとパスワードの値が一致しない" do
    before do
      fill_in "現在のパスワード", with: "password" 
      fill_in "新しいパスワード", with: "updated_pass"
      fill_in "新しいパスワード(確認)", with: "aaaaa"
      click_button "変更"
    end

    it "変更に失敗する" do
      expect(page).to have_content "新しいパスワード(確認)と新しいパスワードの値が一致していません"
    end
  end
  
  context "有効な値を入力する" do
    before do
      fill_in "現在のパスワード", with: "password" 
      fill_in "新しいパスワード", with: "updated_pass"
      fill_in "新しいパスワード(確認)", with: "updated_pass"
      click_button "変更"
    end

    it "変更に成功する" do
      expect(page).to have_css ".alert-success"
    end
  end
end