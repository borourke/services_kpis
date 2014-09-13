class HappinessSurvey < ActiveRecord::Base
  belongs_to :users
  validates :user_id, :meaning, :enthusiasm, :pride, :energy, 
    :recognition, :support, :stamina, :growth, :development, 
    :comments, presence: true

  def self.digest_current_round_submission
    formatted_time
  end

  def self.check_if_survey_already_taken_for_this_month(user_id)
    round = formatted_time
    HappinessSurvey.where(user_id: user_id, round: round).pluck(:id)
  end

  def self.this_months_avg_happiness
    round = formatted_time
    surveys = HappinessSurvey.where(round: round).pluck(:meaning, 
                :enthusiasm, :pride, :energy, :recognition, :support,
                :stamina, :growth, :development)
    surveys.flatten!
    avg = surveys.inject{ |sum, el| sum + el }.to_f / surveys.size
    percent = (avg / 5.0 * 100).round
  end

  private

    def self.formatted_time
      now = Time.now.to_s(:long)
      array = now.split(" ")
      formatted = array[0] + " - " + array[2]
    end

end