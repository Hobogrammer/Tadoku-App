class User < ActiveRecord::Base
  has_many :rounds, dependent: :destroy
  has_many :updates, dependent: :destroy

  validates :name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :time_zone, presence: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.time_zone = auth["extra"]["raw_info"]["time_zone"]
      user.avatar  = auth["info"]["image"]
    end
  end

  def self.fill_avatar
    client = Update.initialize_twitter

    usr_list= User.all

    usr_list.each do |usr|
      if usr.avatar.blank?
        begin
          twi_user = client.user(usr.name)
        rescue Twitter::Error
          puts "Skipping #{usr.name}"
          next
        end
        usr.avatar = twi_user.profile_image_url
        usr.save
        puts "Saved"
      end
    end
  end
end
