module UsersHelper

  def avatar(avatar)
    if avatar.attached?
        rails_blob_url(avatar) 
    else
        ("/assets/sk.jpg")
    end 
  end

end
