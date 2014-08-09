class ReportCard < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	self.inheritance_column = nil
end