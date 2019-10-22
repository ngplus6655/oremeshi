# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  :name => "adminユーザ",
  :login_id => "admin",
  :password => "password", 
  :password_confirmation => "password",
  :gender => 1,
  :birthday => "1990-1-1",
  :prefecture => "東京都",
  :introduce => "管理用アカウントです(admin user)",
  :taste => 1,
  :admin => true
)

count = 0
10.times{
  User.create(
    :name => "佐藤諒",
    :login_id => "test_user" + count.to_s,
    :password => "password", 
    :password_confirmation => "password",
    :gender => 1,
    :birthday => "1991-1-1",
    :prefecture => "東京都",
    :introduce => "世界一くいしんぼうです",
    :taste => 2,
    :admin => false
  )
  count += 1
}

users = User.all
users.each do |user|
  3.times{
    Post.create(
      :title => "テスト用のPostです",
      :body => "おいしいです。おいしいです。おいしいです。おいしいです。おいしいです。おいしいです。おいしいです。",
      :price => 320,
      :review => 5,
      :author => user
    )
  }
end