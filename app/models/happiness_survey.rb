class HappinessSurvey < ActiveRecord::Base
  belongs_to :users
  validates :user_id, :meaning, :enthusiasm, :pride, :energy, 
    :recognition, :support, :stamina, :growth, :development, 
    :comments, presence: true

  FIELD_OPTIONS = ["Gold", "Silver", "Bronze", "None", "N/A"]
  SCORE_FIELDS = ['job', 'delivery', 'project', 'technical', 'efficiency']

  def self.user_happiness_through_time(user_id)
    surveys = HappinessSurvey.where(user_id: user_id)
    surveys.each_with_object([]) do |survey, happiness_by_month|
      happiness_by_month << {
        name: survey.round,
        y: avg_happiness_this_month(survey),
        drilldown: survey.round.gsub(" ", "").gsub("-", "").downcase
      }
    end
  end

  def self.user_happiness_by_category(user_id)
    surveys = HappinessSurvey.where(user_id: user_id)
    surveys.each_with_object([]) do |survey, happiness_by_category_by_month|
      happiness_by_category_by_month << {
        id: survey.round.gsub(" ", "").gsub("-", "").downcase,
        data: [
          ['Meaning', (survey.meaning.to_f / 5.0)*100.round],
          ['Enthusiasm', (survey.enthusiasm.to_f / 5.0)*100.round],
          ['Pride', (survey.pride.to_f / 5.0)*100.round],
          ['Energy', (survey.energy.to_f / 5.0)*100.round],
          ['Recognition', (survey.recognition.to_f / 5.0)*100.round],
          ['Support', (survey.support.to_f / 5.0)*100.round],
          ['Stamina', (survey.stamina.to_f / 5.0)*100.round],
          ['Growth', (survey.growth.to_f / 5.0)*100.round],
          ['Development', (survey.development.to_f / 5.0)*100.round]
        ]
      }
    end
  end

  def self.all_users_happiness_through_time
    rounds = HappinessSurvey.all.pluck(:round).uniq.flatten
    rounds.each_with_object([]) do |round, happiness_by_month|
      surveys = HappinessSurvey.where(round: round).pluck(:meaning, 
                :enthusiasm, :pride, :energy, :recognition, :support,
                :stamina, :growth, :development).flatten!
      avg = surveys.inject{ |sum, el| sum + el }.to_f / surveys.size
      happiness_by_month << {
        name: round,
        y: (avg / 5.0 * 100).round,
        drilldown: round.gsub(" ", "").gsub("-", "").downcase
      }
    end
  end

  def self.all_users_happiness_by_category_by_month
    rounds = HappinessSurvey.all.pluck(:round).uniq.flatten
    rounds.each_with_object([]) do |round, happiness_by_category_by_month|
      meaning_scores = HappinessSurvey.where(round: round).pluck(:meaning).flatten
      meaning_avg = meaning_scores.inject{ |sum, el| sum + el }.to_f / meaning_scores.size
      enthusiasm_scores = HappinessSurvey.where(round: round).pluck(:enthusiasm).flatten
      enthusiasm_avg = enthusiasm_scores.inject{ |sum, el| sum + el }.to_f / enthusiasm_scores.size
      pride_scores = HappinessSurvey.where(round: round).pluck(:pride).flatten
      pride_avg = pride_scores.inject{ |sum, el| sum + el }.to_f / pride_scores.size
      energy_scores = HappinessSurvey.where(round: round).pluck(:energy).flatten
      energy_avg = energy_scores.inject{ |sum, el| sum + el }.to_f / energy_scores.size
      recognition_scores = HappinessSurvey.where(round: round).pluck(:recognition).flatten
      recognition_avg = recognition_scores.inject{ |sum, el| sum + el }.to_f / recognition_scores.size
      support_scores = HappinessSurvey.where(round: round).pluck(:support).flatten
      support_avg = support_scores.inject{ |sum, el| sum + el }.to_f / support_scores.size
      stamina_scores = HappinessSurvey.where(round: round).pluck(:stamina).flatten
      stamina_avg = stamina_scores.inject{ |sum, el| sum + el }.to_f / stamina_scores.size
      growth_scores = HappinessSurvey.where(round: round).pluck(:growth).flatten
      growth_avg = growth_scores.inject{ |sum, el| sum + el }.to_f / growth_scores.size
      development_scores = HappinessSurvey.where(round: round).pluck(:development).flatten
      development_avg = development_scores.inject{ |sum, el| sum + el }.to_f / development_scores.size
      happiness_by_category_by_month << {
        id: round.gsub(" ", "").gsub("-", "").downcase,
        data: [
          ['Meaning', (meaning_avg.to_f / 5.0)*100.round],
          ['Enthusiasm', (enthusiasm_avg.to_f / 5.0)*100.round],
          ['Pride', (pride_avg.to_f / 5.0)*100.round],
          ['Energy', (energy_avg.to_f / 5.0)*100.round],
          ['Recognition', (recognition_avg.to_f / 5.0)*100.round],
          ['Support', (support_avg.to_f / 5.0)*100.round],
          ['Stamina', (stamina_avg.to_f / 5.0)*100.round],
          ['Growth', (growth_avg.to_f / 5.0)*100.round],
          ['Development', (development_avg.to_f / 5.0)*100.round]
        ]
      }
    end
  end

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
    percent = 0 if avg.nil?
    percent = (avg / 5.0 * 100).round
  end

  private

    def self.avg_happiness_this_month(survey)
      responses = survey.slice(:meaning, :enthusiasm, :pride, :energy, 
        :recognition, :support, :stamina, :growth, :development)
      responses = responses.values.flatten
      avg = responses.inject{ |sum, el| sum + el }.to_f / responses.size
      percent = (avg / 5.0 * 100).round
    end

    def self.responses_by_category_this_month(survey)
      responses = survey.slice(:meaning, :enthusiasm, :pride, :energy, 
        :recognition, :support, :stamina, :growth, :development)
    end

    def self.formatted_time
      now = Time.now.to_s(:long)
      array = now.split(" ")
      formatted = array[0] + " - " + array[2]
    end

end