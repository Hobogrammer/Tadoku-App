module Calc

  def self.score_calc(count,med,lang)
    case med
    when "manga"
      count *=  (1/5.0)
    when "game"
      count *= (1/20.0)
    when "fgame"
      count *= (1/6.0)
    when "sub", "subs"
      count *= (1/5.0)
    when "sent", "sentences", "sentence"
      count = sent_count(count,lang)
    when "nico"
      count *= (1/10.0)
    else
      count
    end
  end

  def self.repeat(count,rep)
    count *= (2.0 ** (-rep))
  end

  def self.dr(count)
    count *= 1.48
  end

  def self.sent_count(read,la)
    case la
      when "jp", "it", "es", "en"
        read *= (1/17.0)
      when "eo"
        read *= (1/23.0)
      when "ko"
        read *= (1/18.0)
      when "zh"
        read *= (1/25.0)
      when "de"
        read *= (1/13.0)
      when "fr"
        read *= (1/16.0)
      when "ru"
        read *= (1/24.0)
      when "nl"
        read *= (1/30.0)
      when "af"
        read *= (1/31.0)
      when "ar"
        read *= (1/8.0)
      when "vi"
        read *= (1/15.0)
      else
        read *= (1/33.0)
    end
  end

  def self.usermed_info(user,round)
    round_info = user.rounds.find_by_round_id(round)
    sent_raw = user.updates.where(:medium => 'sent', :round_id => round).sum(:raw)

    book_point = round_info.book.to_f
    manga_point = round_info.manga.to_f / 5
    net_point = round_info.net.to_f
    fgame_point = round_info.fgame.to_f / 6
    game_point = round_info.game.to_f / 20
    lyric_point = round_info.lyric.to_f
    subs_point = round_info.subs.to_f / 5
    news_point = round_info.news.to_f
    nico_point = round_info.nico / 10
    sent_point = round_info.pcount.to_f - (book_point + manga_point + net_point + fgame_point + game_point + lyric_point + subs_point + news_point + nico_point) #cheatcodes

    book_percent =  ((book_point / round_info.pcount)*100)
    manga_percent = ((manga_point / round_info.pcount)*100)
    net_percent = ((net_point / round_info.pcount)*100)
    fgame_percent = ((fgame_point / round_info.pcount)*100)
    game_percent = ((game_point / round_info.pcount)*100)
    lyric_percent = ((lyric_point / round_info.pcount)*100)
    subs_percent = ((subs_point / round_info.pcount)*100)
    news_percent = ((news_point / round_info.pcount)*100)
    nico_percent = ((nico_point / round_info.pcount)*100)
    sent_percent = ((sent_point / round_info.pcount) *100)

    user_med = {
      "book" => {"points" => book_point, "percent" => book_percent.to_f, "raw" => round_info.book.to_f},
      "manga" => {"points" => manga_point, "percent" => manga_percent.to_f, "raw" => round_info.manga.to_f},
      "net" => {"points" => net_point, "percent" => net_percent.to_f, "raw" => round_info.net.to_f},
      "fgame" => {"points" => fgame_point, "percent" => fgame_percent.to_f, "raw" => round_info.fgame.to_f},
      "game" => {"points" => game_point, "percent" => game_percent.to_f, "raw" => round_info.game.to_f},
      "lyric" => {"points" => lyric_point, "percent" => lyric_percent.to_f, "raw" => round_info.lyric.to_f},
      "subs" => {"points" => subs_point, "percent" => subs_percent.to_f, "raw" => round_info.subs.to_f},
      "news" => {"points" => news_point, "percent" => news_percent.to_f, "raw" => round_info.news.to_f},
      "nico" => {"points" => nico_point, "percent" => nico_percent.to_f, "raw" => round_info.nico.to_f},
      "sent" => {"points" => sent_point, "percent" =>sent_percent.to_f, "raw" => sent_raw.to_f},
      "total" => round_info.pcount
    }
  end
end
