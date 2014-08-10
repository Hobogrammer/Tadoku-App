class Update < ActiveRecord::Base
  belongs_to :user

  validates :newread, presence: true
  validates :medium, presence: true
  validates :lang, presence: true

LANGUAGES = {
      'Afrikaans' => 'af',
      'Arabic' => 'ar',
      'Belarusian' => 'be',
      'Chinese' => 'zh',
      'Croatian' => 'hr',
      'Dutch' => 'nl',
      'English' => 'en',
      'Esperanto' => 'eo',
      'Finnish' => 'fi',
      'French' => 'fr',
      'German' => 'de',
      'Greek' => 'el',
      'Hebrew' => 'he',
      'Italian' => 'it',
      'Japanese' => 'jp',
      'Korean' => 'ko',
      'Polish' => 'pl',
      'Portuguese' => 'pt',
      'Russian' => 'ru',
      'Spanish' => 'es',
      'Swedish' => 'sv',
      'Thai' => 'th',
      'Vietnamese' => 'vi'
    }

  def self.undo_update(update, user)
    undo_read_amount, undo_med = update.raw.to_f , update.medium
    usr_round = user.rounds.find_by_round_id(ApplicationHelper.curr_round)

    revised_total = usr_round.pcount.to_f - update.newread.to_f
    old_med_read = usr_round.send(undo_med).to_f
    revised_med_read = old_med_read.to_f - undo_read_amount.to_f
    usr_round.update_attributes(undo_med.to_sym => revised_med_read)

    usr_round.update_attributes(:pcount => revised_total)
    update.destroy
  end

  def self.user_langs(user,round)
    round_info = user.rounds.find_by_round_id(round)
    lang_rry = [round_info.lang1, round_info.lang2,round_info.lang3]
    lang_hash = Hash.new

    lang_rry.each do |reglang|
      if !reglang.empty?
        case reglang
        when 'af'
          lang_hash['Afrikaans'] = 'af'
        when 'ar'
          lang_hash['Arabic'] = 'ar'
        when 'be'
          lang_hash['Belarusian'] = 'be'
        when 'zh'
          lang_hash['Chinese'] = 'zh'
        when 'hr'
          lang_hash['Croatian'] = 'hr'
        when 'nl'
          lang_hash['Dutch'] = 'nl'
        when 'en'
          lang_hash['English'] = 'en'
        when 'eo'
          lang_hash['Esperanto'] = 'eo'
        when 'es'
          lang_hash['Spanish'] = 'es'
        when 'fi'
          lang_hash['Finnish'] = 'fi'
        when 'fr'
          lang_hash['French'] = 'fr'
        when 'de'
          lang_hash['German'] = 'de'
        when 'el'
          lang_hash['Greek'] = 'el'
        when 'he'
          lang_hash['Hebrew'] = 'he'
        when 'it'
          lang_hash['Italian'] = 'it'
        when 'jp'
          lang_hash['Japanese'] = 'jp'
        when 'ko'
          lang_hash['Korean'] = 'ko'
        when 'pl'
          lang_hash['Polish'] = 'pl'
        when 'pt'
          lang_hash['Portuguese'] = 'pt'
        when 'ru'
          lang_hash['Russian'] = 'ru'
        when 'sv'
          lang_hash['Swedish'] = 'sv'
        when 'th'
          lang_hash['Thai'] = 'th'
        when 'vi'
          lang_hash['Vietnamese'] = 'vi'
        end
      end
    end
    return lang_hash
  end

  def self.created_at_update
  canidates = Update.includes(:user).where(:round_id => 201301)

    canidates.each do |update|
      usr_tz = update.user.time_zone
      conv_time = update.created_at.in_time_zone(usr_tz)
      off = conv_time.utc_offset
      update.created_at_in_user_time = (update.created_at + off)
      update.save
    end
  end

  def self.initialize_twitter
     config = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["CONSUMER_KEY"]
      config.consumer_secret = ENV["CONSUMER_SECRET"]
      config.access_token = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end
    config
  end
end
