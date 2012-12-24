class Update < ActiveRecord::Base
  attr_accessible :raw, :medium, :newread, :recpage, :round_id, :user_id, :lang, :dr, :repeat

  def self.undo (user,round)
  		del_update = user.updates.where(:round_id => round).last
  		del_read = del_update.newread.to_f 
  		rev_total = del_update.recpage.to_f
  		del_update.destroy
  		return rev_total
  end
end
