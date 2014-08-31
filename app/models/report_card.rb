class ReportCard < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	self.inheritance_column = nil
  validates :project_name, :type, :user_name, :cml_clean, :cml_commented, :instructions, :tags, :code_clean, :code_utilized, :code_advanced, :complex_solution, :delivery_timely, :delivery_docs, :communication, :accuracy, :spoilage, :best_in_class, :comments, :project_id, presence: true
end