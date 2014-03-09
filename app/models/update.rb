class Update < ActiveRecord::Base
  attr_accessible :raw, :medium, :newread, :recpage, :round_id, :user_id, :lang, :dr, :repeat, :created_at_in_user_time
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
      'Thai' => 'th'
    }

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
end
