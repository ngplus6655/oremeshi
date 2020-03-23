require 'rails_helper'

describe 'account機能', type: :system do
  let(:user_a) { FactoryBot.create(:user) }

  describe 'アカウント詳細ページ' do
    context 'テストユーザがログインしているとき' do
      before do
        visit root_path
        fill_in 'ログインID：', with: user_a.login_id
        fill_in 'パスワード：', with: user_a.password
        click_button 'ログイン'
      end

      it 'テストユーザのプロフィールが表示される' do
        click_link "マイページ"
        expect(page).to have_content user_a.name
        expect(page).to have_content user_a.prefecture
        expect(page).to have_content user_a.introduce
      end
    end
  end

  describe 'アカウント編集ページ' do
    context 'テストユーザがログインしているとき' do
      before do
        visit root_path
        fill_in 'ログインID：', with: user_a.login_id
        fill_in 'パスワード：', with: user_a.password
        click_button 'ログイン'
      end

      it 'テストユーザのプロフィールの編集が成功する' do
        click_link "ユーザ情報を編集する"
        expect(page).to have_field 'ユーザー名', with: user_a.name

        fill_in "ユーザー名", with: "編集済みテストユーザ"
        # fill_in "ログインID", with: "updated_login_id"
        choose "女性"
        # 誕生日(date_select)
        select "2000", from: "user_birthday_1i"
        select "9月", from: "user_birthday_2i"
        select "31", from: "user_birthday_3i"

        select "北海道", from: "都道府県"
        fill_in "自己紹介文", with: "編集済みの自己紹介文"
        # 味覚
        find("input[name='user[taste]'][value='2']").set(true)
        
        attach_file 'プロフィール画像',
         "#{Rails.root}/spec/factories/profile_image.jpg"
        
        click_button "登録"
        expect(page).to have_css '.alert-success'
      end
    end
  end
end