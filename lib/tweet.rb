module Tweet

  def self.tweet_up(user,total,rank,client)
    message = ".@#{user.name} has #{total} pages recorded and a rank of #{rank}."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update(".@#{user.name} has #{total} pages recorded and a rank of #{rank}. #{rand(1000)}")
  end

  def self.regis_tweet(user,round,client)
    message = "@#{user.name}, you are registered reading #{round.lang1.to_s} #{round.lang2.to_s} #{round.lang3.to_s} goal: #{round.goal.to_s}."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user.name}, you are registered reading #{round.lang1.to_s}, #{round.lang2.to_s}, and #{round.lang3.to_s} goal: #{round.goal.to_s}. #{rand(1000)}")
  end

  def self.undo_tweet(user,total,rank,client)
    message = ".@#{user.name} has a revised score of #{total} and revised rank of #{rank}."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update(".@#{user.name} has a revised score of #{total} and revised rank of #{rank}. #{rand(1000)}")
  end

  def self.not_regis(user,client)
    message = "@#{user}, you are not registered for this round. Please register and try again."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user}, you are not registered for this round. Please register and try again. #{rand(1000)}")
  end

  def self.regis_exceed(user,client)
    message = "@#{user}, you may only register for 3 languages. Your first three choices will be used."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user}, you may only register for 3 languages. Your first three choices will be used. #{rand(1000)}")
  end

  def self.already_regis(user,client)
    message = "@#{user}, you are already registered for the current round."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user}, you are already registered for the current round. #{rand(1000)}")
  end

  def self.not_regis_lang(user,lang,client)
    message = "@#{user}, '#{lang}' is not one of your registered reading languages. Update skipped."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user}, '#{lang}' is not one of your registered reading languages. Update skipped. #{rand(1000)}")
  end

  def self.goal_update(user,goal,client)
    message = "@#{user}, your goal has been updated to #{goal} pages."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user}, your goal has been updated to #{goal} pages. #{rand(1000)}")
  end

  def self.no_undo(user,client)
    message = "@#{user.name}, you do not have any updates to undo."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user.name}, you do not have any updates to undo.  #{rand(1000)}")
  end

  def self.no_tz(user,client)
    message = "@#{user}, please set the timezone in your account settings and try again."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user}, please set the timezone in your account settings and try again. #{rand(1000)}")
  end

  def self.early_warn(user,client,start_time)
    message = "@#{user}, you're too early. Contest starts #{start_time.to_date} 00:00:00 your time."
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user}, you're too early. Contest starts #{start_time.to_date} 00:00:00 your time. #{rand(1000)}")
  end

  def self.late_submit(user,client)
    message = "@#{user}, sorry, the contest has already ended in your timezone"
    return message if Rails.env.test?
    client.update(message)
  rescue
    client.update("@#{user}, sorry, the contest has already ended in your timezone. #{rand(1000)}")
  end
end
