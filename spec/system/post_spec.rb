require 'rails_helper'

describe '俺飯投稿機能', type: :system do
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
end
