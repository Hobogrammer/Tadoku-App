class Report

  def generate_report(round)
    date = DateTime.now.strftime("%Y_%m_%d")
    file_name = "Tadoku_Report_" + date
    report = File.new("#{file_name}.txt", "w")

    entrants = Round.includes(:user).where(:round_id => round)

    report.puts "<ol>"

    entrants.each do |entrant|
      if (entrant.pcount.to_f < entrant.goal.to_f) && entrant.goal.to_f > 0
        report.puts "<li><span style='color:#99cc00;'>#{entrant.user.name} #{entrant.pcount.round(2)} </span></li>"
      else
        report.puts "<li>#{entrant.user.name} #{entrant.pcount.round(2)}</li>"
      end
    end

    report.puts "</ol>"
    report.puts "\n"

    report.puts "Congratulations to <strong> #{entrants.first.user.name}</strong>"

    report.puts "\n"

    report.puts "<h4>MEDIUM CHAMPS</h4>"
    report.puts "<ul>"

    top_book = Round.includes(:user).where(:round_id => round).reorder('book desc').limit(2)
      report.puts "<li>#{top_book.first.user.name} is our top book reader with #{top_book.first.book.to_f} book pages read.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_book.last.user.name} with #{top_book.last.book.to_f} pages recorded.</li>"
      report.puts "</ul>"

    top_manga = Round.includes(:user).where(:round_id => round).reorder('manga desc').limit(2)
      report.puts "<li>#{top_manga.first.user.name} is our top manga reader with #{top_manga.first.manga.to_f} manga pages read.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_manga.last.user.name} with #{top_manga.last.manga.to_f} pages recorded.</li>"
      report.puts "</ul>"


    top_net = Round.includes(:user).where(:round_id => round).reorder('net desc').limit(2)
      report.puts "<li>#{top_net.first.user.name} is our top net reader with #{top_net.first.net.to_f} net pages read.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_net.last.user.name} with #{top_net.last.net.to_f} pages recorded.</li>"
      report.puts "</ul>"

    top_game = Round.includes(:user).where(:round_id => round).reorder('game desc').limit(2)
      report.puts "<li>#{top_game.first.user.name} is our top game reader with #{top_game.first.game.to_f} game screens read.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_game.last.user.name} with #{top_game.last.game.to_f} screens recorded.</li>"
      report.puts "</ul>"

    top_fgame = Round.includes(:user).where(:round_id => round).reorder('fgame desc').limit(2)
      report.puts "<li>#{top_fgame.first.user.name} is our top fgame reader with #{top_fgame.first.fgame.to_f} full game screens read.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_fgame.last.user.name} with #{top_fgame.last.fgame.to_f} screens recorded.</li>"
      report.puts "</ul>"

    top_lyric = Round.includes(:user).where(:round_id => round).reorder('lyric desc').limit(2)
      report.puts "<li>#{top_lyric.first.user.name} is our top lyric reader with #{top_lyric.first.lyric.to_f} lyrics read.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_lyric.last.user.name} with #{top_lyric.last.lyric.to_f} lyrics recorded.</li>"
      report.puts "</ul>"

    top_subs = Round.includes(:user).where(:round_id => round).reorder('subs desc').limit(2)
      report.puts "<li>#{top_subs.first.user.name} is our top subs reader with #{top_subs.first.subs.to_f} minutes of subs watched.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_subs.last.user.name} with #{top_subs.last.subs.to_f} minutes recorded.</li>"
      report.puts "</ul>"

    top_news = Round.includes(:user).where(:round_id => round).reorder('news desc').limit(2)
      report.puts "<li>#{top_news.first.user.name} is our top news reader with #{top_news.first.news.to_f} news articles read.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_news.last.user.name} with #{top_news.last.news.to_f} articles recorded.</li>"
      report.puts "</ul>"

    top_sent = Round.includes(:user).where(:round_id => round).reorder('sent desc').limit(2)
      report.puts "<li>#{top_sent.first.user.name} is our top sent reader with #{top_sent.first.sent.to_f} sentences read.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_sent.last.user.name} with #{top_sent.last.sent.to_f} sentences recorded.</li>"
      report.puts "</ul>"


    top_nico = Round.includes(:user).where(:round_id => round).reorder('nico desc').limit(2)
      report.puts "<li>#{top_nico.first.user.name} is our top nico reader with #{top_nico.first.nico.to_f} nico watched.</li>"
      report.puts "<ul>"
      report.puts "<li>honorable mention goes to #{top_nico.last.user.name} with #{top_nico.last.nico.to_f} nico recorded.</li>"
      report.puts "</ul>"


    report.puts "</ul>"
    report.puts "\n"

    lang_list = Update.where(:round_id => round).select(:lang).uniq
    lang_l = lang_list.map(&:lang)
    lang_l.each do |lang|
      lang_top = Hash.new
      report.puts "<h5>  Top 3 #{lang} readers</h5>"
      report.puts "<ol>"
      top_lang_readers = Round.includes(:user).where("round_id = ? and (lang1 = ? or lang2 = ? or lang3 = ?)", round, lang, lang, lang)
      top_lang_readers.each do |top_reader|
        total = 0
        langups = top_reader.user.updates.where(:round_id => round, :lang => lang).select("sum(newread) as  accum")
        total= langups.map(&:accum)
        total = total[0]
        puts total.class
        lang_top["#{top_reader.user.name}"] = total
      end
      lang_sort = lang_top.sort_by {|k,v| v  || 0}
      lang_sort = lang_sort.reverse
      lang_sort.each do |lang_t|
        report.puts "<li>#{lang_t[0]}  #{lang_t[1]}</li>"
      end
      report.puts "</ol>"
      report.puts "\n"
    end
    report.close
  end
end
