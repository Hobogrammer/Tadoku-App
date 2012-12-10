class BotTaskTask < Scheduler::SchedulerTask
  environments :development
  # environments :staging, :production
  
  every '1m'
  # other examples:
  # every '24h', :first_at => Chronic.parse('next midnight')
  # cron '* 4 * * *'  # cron style
  # in '30s'          # run once, 30 seconds from scheduler start/restart
  
  
  def run
    # Your code here, eg: 
    # User.send_due_invoices!
    
    # use log() for writing to scheduler daemon log
    lib/bot.rb
    log("Bot Ran!")
  end
end