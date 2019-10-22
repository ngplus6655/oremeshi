module PostsHelper
  def create_review_array
    count = 0
    array = []
    while count <= 5
      array.push([count.round(1).to_s, count.round(1).to_s])
      count = count + 0.1
    end
    array
  end

  def create_user_id_array
    @user_ids = 
    @users.map do |user|
      ["#{user.login_id}" , "#{user.id}"]
    end
    @user_ids
  end

end
