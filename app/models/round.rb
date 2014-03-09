class Round < ActiveRecord::Base
  attr_accessible :book, :fgame, :game, :gmet, :goal, :lang1, :lang2, :lang3, :lyric, :manga, :net, :news, :nico, :pcount, :round_id, :sent, :subs, :user_id, :tier
  belongs_to :user

  validates :round_id, presence: true

  default_scope order: 'rounds.pcount DESC'

  def self.rank(user,roundid)
    part_list = Round.where(:round_id => roundid)

    i = 1
    part_list.each do |list|
      if (user.id == list.user_id)
        rank = i
      end
      i += 1
    end
  end

  def self.round_restore
    client = Twitter::Client.new

    File.readlines("/home/silent/projects/rails/tadoku-app/oldDB/tadoku04.csv").each do |row|
      row = row.gsub('"', "")
      row = row.split(/;/)

      pre_usr = row[1].to_s
      usr = User.find_by_name(pre_usr)

      uid = rand(100000)

      if usr.nil?
        begin
          twi_usr = client.user(pre_usr)
          puts "called to twitter"
        rescue Twitter::Error
          puts "Twitter error"
          usr = User.new(:name => pre_usr, :provider => "twitter", :uid => uid, :time_zone => "UTC")
          usr.save
        else
          puts "call twitter call OK"
          tz = twi_usr.time_zone

          if tz.nil?
           tz = "UTC" # Wouldn't let me directly assign .time_zone
          end
          new_usr = User.new(:name => pre_usr, :provider => "twitter", :uid => twi_usr.id, :time_zone => tz)
          new_usr.save
        end
      end

      puts "making round for user"
      usr = User.find_by_name(pre_usr)
      rest_round = usr.rounds.new(:round_id => "201110")
      rest_round.save

      usr.rounds.find_by_round_id("201110").update_attributes(:lang1 => row[13] , :lang2 => row[14] , :lang3 => row[15] ,
        :book => row[2], :manga => row[3], :net => row[4], :fgame => row[5], :game => row[6], :lyric => row[7], :subs => row[8],
        :news => row[9], :sent => row[10], :nico => row[11], :pcount => row[12])

    end
  end

  def self.restore_zero
    client = Twitter::Client.new

    File.readlines("/home/silent/projects/rails/tadoku-app/oldDB/ranking.csv").each do |row|
      row = row.gsub('"', "")
      row = row.split(/;/)

      pre_usr = row[1].to_s
      usr = User.find_by_name(pre_usr)

      uid = rand(100000)

      if usr.nil?
        begin
          twi_usr = client.user(pre_usr)
          puts "called to twitter"
        rescue Twitter::Error
          puts "Twitter error"
          usr = User.new(:name => pre_usr, :provider => "twitter", :uid => uid, :time_zone => "UTC")
          usr.save
        else
          puts "call twitter call OK"
          tz = twi_usr.time_zone

          if tz.nil?
            tz = "UTC" # Wouldn't let me directly assign .time_zone
          end
          new_usr = User.new(:name => pre_usr, :provider => "twitter", :uid => twi_usr.id, :time_zone => tz)
          new_usr.save
        end
      end

      puts "making round for user"
      usr = User.find_by_name(pre_usr)
      rest_round = usr.rounds.new(:round_id => "201008")
      rest_round.save

      usr.rounds.find_by_round_id("201008").update_attributes(:lang1 => "jp", :pcount => row[2])
    end
  end

  def self.over_round_fill
    user_list = User.all
    user_list.each do |user|
      usr_rounds = user.rounds.all
      total = book_tot = manga_tot = game_tot = fgame_tot = news_tot = net_tot =  lyric_tot = subs_tot = sent_tot = nico_tot = 0

      usr_rounds.each do |round|
        book_tot += round.book
        manga_tot += round.manga
        net_tot += round.net
        game_tot += round.game
        fgame_tot += round.fgame
        news_tot += round.news
        lyric_tot += round.lyric
        subs_tot += round.subs
        sent_tot += round.sent
        nico_tot += round.nico
       total += round.pcount
      end
      over_round = user.rounds.new(:round_id => 000001, :book => book_tot, :manga=> manga_tot, :net => net_tot,
        :game => game_tot, :fgame => fgame_tot, :news => news_tot, :lyric => lyric_tot, :subs => subs_tot,
        :sent => sent_tot, :nico => nico_tot, :pcount => total)
      over_round.save
    end
  end

  def self.over_correct
    user_list = User.all
    user_list.each do |user|
      user_rounds = user.rounds.where(Round.arel_table[:round_id].not_eq(1))
      if user_rounds.empty?
        next
      else
        total = 0
        user_rounds.each do |round|
          total += round.pcount
        end
        user.rounds.find_by_round_id(1).update_attributes(:pcount => total)
      end
    end
  end
end
