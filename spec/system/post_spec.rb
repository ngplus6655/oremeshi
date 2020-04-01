require 'rails_helper'

describe '俺飯投稿機能', type: :system, js: true do
  let(:user_a) { FactoryBot.create(:user, name: "佐藤諒") }
  let!(:post_1) { FactoryBot.create(:post, author: user_a) }

  describe "一覧表示機能" do
    let(:user_b) { FactoryBot.create(:user, name: "加藤諒", login_id: "test_user_2") }
    let!(:post_2) { FactoryBot.create(:post, title: "テスト用ポスト2", author: user_b) }

    before do
      visit root_url
    end
    it "作成済みの投稿が表示される" do
      expect(page).to have_content post_1.title
      expect(page).to have_content post_1.author.name
      expect(page).to have_content post_2.title
      expect(page).to have_content post_2.author.name
    end
  end


  describe "詳細表示機能" do
    context "ログインユーザの有無に限らず"  do
      before do
        visit post_url(post_1)
      end
  
      it "投稿内容の詳細が表示される" do
        expect(page).to have_content post_1.body
        expect(page).to have_content post_1.price
      end

      it "投稿したユーザの情報が表示される" do
        expect(page).to have_content post_1.author.name
        expect(page).to have_content post_1.author.introduce
        if post_1.author.taste == 1
          expect(page).to have_content "甘党"
        else
          expect(page).to have_content "辛党"
        end
      end

      it "編集/削除リンクが表示されない" do
        expect(page).not_to have_content "変更する"
        expect(page).not_to have_content "削除する"
      end
    end
    
    context "テストユーザがログインしているとき" do
      before do
        login(user_a)
        click_link "詳細ページへ"
      end

      it "コメントの投稿に成功する" do
        find("#comment_content").set("テストコメント。おいしそうです!!")
        click_button "送信"
        expect(page).to have_content "テストコメント。おいしそうです!!"
      end

      it "編集/削除リンクが表示される" do
        expect(page).to have_content "変更する"
        expect(page).to have_content "削除する"
      end
    end       
  end


  describe "投稿機能" do
    context "テストユーザがログインしているとき" do
      before do
        login(user_a)
      end

      context "有効なデータを入力する" do
        before do
          click_on "俺飯を投稿する", match: :first
          fill_in "タイトル", with: "テスト用のポスト"
          fill_in "金額", with: 1999
          select "4.5", from: "post_review"
          fill_in "感想", with: "今までで一番おいしい食べ物だった！"
          attach_file '画像',
         "#{Rails.root}/spec/factories/profile_image.jpg" 
          click_button "投稿する"
        end

        it "投稿に成功する" do
          expect(page).to have_content "テスト用のポスト"
          expect(page).to have_content 1999
        end
      end

      context "無効なデータを入力する" do
        before do
          click_on "俺飯を投稿する", match: :first
          fill_in "タイトル", with: ""
          fill_in "金額", with: ""
          select "4.5", from: ""
          fill_in "感想", with: ""
          click_button "投稿する"
        end

        it "投稿に失敗する" do
          expect(page).to have_css ".alert-danger"
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "金額を入力してください"
        end
      end
    end

    context "ログインユーザが存在しないとき" do
      before do
        visit new_post_path
      end

      it "投稿ページを表示しない" do
        expect(page).not_to have_button "投稿する"
        expect(page).to have_css ".alert-info"
      end
    end
  end


  describe "編集機能" do
    context " テストユーザがログインしているとき" do
      before do
        login(user_a)
        click_link "詳細ページへ"
        click_link "変更する"
      end

      context "有効なデータを入力する" do
        before do
          fill_in "タイトル", with: "編集済みタイトル"
          fill_in "金額", with: 100
          click_button "投稿する"
        end

        it "編集に成功する" do
          expect(page).to have_css ".alert-success"
          expect(page).to have_content "編集済みタイトル"
          expect(page).to have_content "100"
        end
      end

      context "無効なデータを入力する" do
        before do
          fill_in "タイトル", with: ""
          fill_in "金額", with: ""
          click_button "投稿する"
        end

        it "編集に失敗する" do
          expect(page).to have_css ".alert-danger"
          expect(page).to have_content "タイトルを入力してください"
          expect(page).to have_content "金額を入力してください"
        end
      end
    end

    context "ログインしていないとき" do
      before do
        visit edit_post_url(post_1)
      end

      it "編集に失敗する" do
        expect(page).not_to have_button "投稿する"
        expect(page).not_to have_button "タイトル"
        expect(page).to have_css ".alert-info"
      end
    end
  end

  describe "削除機能" do
    context "ログインしているとき" do
      before do
        login(user_a)
        click_on "詳細ページへ"
        click_on "削除する"
        page.driver.browser.switch_to.alert.accept
      end

      it "削除に成功する" do
        expect(page).to have_css ".alert-info"
      end
    end
  end

end
