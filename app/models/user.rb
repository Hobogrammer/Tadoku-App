class User < ApplicationRecord

  def self.find_or_create_from_auth_hash(auth_hash)
    create! do |user|
      user.provider = auth_hash[:provider]
      user.uid = auth_hash[:uid]
      user.name = auth_hash[:info][:nickname]
      user.profile_img = auth_hash[:info][:image]
      user.timezone = auth_hash[:extra][:raw_info][:time_zone]
    end
  end
end
