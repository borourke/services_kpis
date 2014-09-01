class ReportCard < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	self.inheritance_column = nil
  validates :project_name, :user_name, :comments, :project_id, :job_score, :technical_score, :project_score, presence: true
  serialize :job_array, Array
  serialize :technical_array, Array
  serialize :project_array, Array

  def self.generate_report_card_admin_tables
    report_cards = ReportCard.all
    report_cards.each_with_object([]) do |report_card, array|
      hash = {}
      hash["project_name"] = report_card.project_name
      hash["services_member"] = report_card.user_name
      hash["job_score"] = report_card.job_score
      hash["technical_score"] = report_card.technical_score
      hash["project_score"] = report_card.project_score
      hash["efficiency_score"] = report_card.efficiency_score
      all = report_card.job_array + report_card.project_array + report_card.technical_array
      all.reject! { |x| x.empty? }
      hash["points"] = all.length
      hash["comments"] = report_card.comments
      hash["report_card_id"] = report_card.id
      job_array = report_card.job_array.reject { |x| x.empty? }
      hash["job_array"] = job_array.join(", ")
      technical_array = report_card.technical_array.reject { |x| x.empty? }
      hash["technical_array"] = technical_array.join(", ")
      project_array = report_card.project_array.reject { |x| x.empty? }
      hash["project_array"] = project_array.join(", ")
      array << hash
    end
  end

end