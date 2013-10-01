# the gem
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"

# the model
class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end

# generate db table
rails g paperclip user avatar

# the form partial
= form.file_field :avatar

# in users_controller.rb
def user_params
  params.require(:user).permit(:name, :avatar)
end

# show and index views
= image_tag @user.avatar.url
= image_tag @user.avatar.url(:medium)
= image_tag @user.avatar.url(:thumb)

# To detach a file, simply set the attribute to nil:
@user.avatar = nil
@user.save
