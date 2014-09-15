class Survey < ActiveRecord::Base
  belongs_to :users

  def self.generate_surveys_table(user)
    surveys = Survey.where(user_id: user.id)
    surveys.each_with_object([]) do |survey, array|
      array << {
        "name" => survey.title, 
        "owner" => survey.job_owner, 
        "pn" => survey.project_number,
        "respondants" => survey.respondants, 
        "pay" => survey.payment_cents, 
        "created_at" => survey.created_at.in_time_zone("Pacific Time (US & Canada)").to_s(:long),
        "id" => survey.id
        }
    end
  end
end
