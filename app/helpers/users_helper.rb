module UsersHelper

  def avatar(user)
    if user.avatar.attached?
        rails_blob_url(user.avatar).variant(auto_orient: true)
    else
      if user.gender = 1
        ("/assets/default.jpg")
      else
        ("/assets/default1.jpg")
      end 
    end 
  end

end
