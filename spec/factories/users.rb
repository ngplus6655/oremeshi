FactoryBot.define do
  factry :user do
    name { 'テストユーザ' }
    login_id { 'test_user' }
    password { 'password' }
    password_confirmation { 'password' }
    gender { 1 }
    birthday { "1990-1-1" }
    prefecture { "東京都" }
    introduce { "世界一の食いしん坊" }
    taste  { 1 }
    admin { "false" }
  end

  factry :admin_user, class: User do
    name { 'adminユーザ' }
    login_id { 'admin_user' }
    password { 'password' }
    password_confirmation { 'password' }
    gender { 2 }
    birthday { "1998-1-1" }
    prefecture { "埼玉県" }
    introduce { "管理者アカウント" }
    taste  { 1 }
    admin { "true" }
  end
end