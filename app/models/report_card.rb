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
      all = report_card.job_array + report_card.project_array + report_card.technical_array
      all.reject! { |x| x.empty? }
      job_array = report_card.job_array.reject { |x| x.empty? }
      technical_array = report_card.technical_array.reject { |x| x.empty? }
      project_array = report_card.project_array.reject { |x| x.empty? }
      hash = {

        project_name: report_card.project_name,
        services_member: report_card.user_name,
        job_score: report_card.job_score,
        technical_score: report_card.technical_score,
        project_score: report_card.project_score,
        efficiency_score: report_card.efficiency_score,
        points: all.length,
        comments: report_card.comments,
        report_card_id: report_card.id,
        job_array: job_array.join(", "),
        technical_array: technical_array.join(", "),
        project_array: project_array.join(", ")

      }
      array << hash
    end
  end

  def self.get_all_services_members
    users = User.all
    users.each_with_object([]) do |user, array|
      array << user.name
    end
  end

  def self.get_all_project_names
    projects = Project.all
  end
end