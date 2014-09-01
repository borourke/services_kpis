class ReportCard < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	self.inheritance_column = nil
  validates :project_name, :user_name, :comments, :project_id, :job_score, :technical_score, :project_score, presence: true
  serialize :job_array, Array
  serialize :technical_array, Array
  serialize :project_array, Array

  def generate_report_card_tables


  end

end