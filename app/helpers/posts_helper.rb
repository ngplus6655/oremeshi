module PostsHelper

  # 0~5まで0.5刻みの二次元配列を作成
  def create_review_array
    array = []
    (0..10).each do |n|
      num = n/2.to_f
      array << [num, num]
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

  def create_review_star(post)
    html = []
    comp_star = post.review.to_i
    harf_star = post.review%1
    star_count = 0

    comp_star.times do
      html.push('<i class="fas fa-star"></i>')
      star_count += 1
    end
    if harf_star == 0.5
      html.push('<i class="fas fa-star-half-alt"></i>')
      star_count += 1
    end
    rest_star = 5 - star_count
    rest_star.times do
      html.push('<i class="far fa-star"></i>')
    end
    star_icon = html.join
    star_icon
  end

  def index_image(images)
    if images.attached?
      images.first.variant(auto_orient: true)
      rails_blob_url(images.first)
    else
        ("/assets/hakumai.png")
    end 
  end


end
