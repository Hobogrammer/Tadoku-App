module UsersHelper

  def medium_helper(med)
    case med
    when 'book'
      pg = "page"
    when 'manga'
      pg = "page"
    when 'net'
      pg = "web article"
    when 'fgame'
      pg = "screen"
    when 'game'
      pg = "screen"
    when 'subs'
      pg = "minute"
    when 'news'
      pg = "article"
    when 'sent'
      pg = "sentence"
    when 'nico'
      pg = "minute"
    when 'lyric'
      pg = "lyric"
    end
  end

  def meter_graph_helper(usr,round_list)
    round_list.each do |r|
      start_date = UpdatesHelper::start_date_full(r.to_s)
      end_date = UpdatesHelper::end_date_full(r.to_s)
      updates = usr.updates.where(:round_id => r).group("date(created_at_in_user_time)").select("created_at_in_user_time,sum(newread) as day_total")
      (start_date.to_date..(now.to_date > end_date.to_date ? end_date.to_date : now.to_date)).map do |date|
        update =  updates.detect{ |update|
        update.created_at_in_user_time.to_date == date }
        update && update.day_total.to_f || 0
      end.inspect
    end
  end
end
