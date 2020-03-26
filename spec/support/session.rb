module Session
  def login(user)
    visit root_path
    fill_in 'ログインID：', with: user.login_id
    fill_in 'パスワード：', with: user.password
    click_button 'ログイン'
  end
end