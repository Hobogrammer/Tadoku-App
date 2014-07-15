class Round < ActiveRecord::Base
  belongs_to :user

  validates :round_id, presence: true
  validates :user_id, presence: true

 default_scope { order( :pcount => :desc ) }

  def self.rank(user,roundid)
    part_list = Round.where(:round_id => roundid)

    i = 1
    part_list.each do |list|
      if (user.id == list.user_id)
        return i
      end
      i += 1
    end
  end

  def self.registraton_check(user)
     current_user_round = user.rounds.find_by_round_id(ApplicationHelper.curr_round)

     if current_user_round
      current_user_round
    else
      false
    end
  end
end
