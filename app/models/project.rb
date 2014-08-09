class Project < ActiveRecord::Base
	belongs_to :clients
	has_many :report_cards
end
