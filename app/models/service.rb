class Service < ActiveRecord::Base
	
	def self.get_medal_count(current_user)
		report_cards = ReportCard.where(user_id: current_user.id)
		medals_array = []
		report_cards.each_with_object(Hash.new(0)) do |report_card, hash|
			hash["Gold"] += 1 if report_card.job_score == "Gold"
			hash["Gold"] += 1 if report_card.delivery_score == "Gold"	
			hash["Gold"] += 1 if report_card.project_score == "Gold"	
			hash["Gold"] += 1 if report_card.technical_score == "Gold"
			hash["Gold"] += 1 if report_card.efficiency_score == "Gold"
			hash["Silver"] += 1 if report_card.job_score == "Silver"
			hash["Silver"] += 1 if report_card.delivery_score == "Silver"	
			hash["Silver"] += 1 if report_card.project_score == "Silver"	
			hash["Silver"] += 1 if report_card.technical_score == "Silver"
			hash["Silver"] += 1 if report_card.efficiency_score == "Silver"
			hash["Bronze"] += 1 if report_card.job_score == "Bronze"
			hash["Bronze"] += 1 if report_card.delivery_score == "Bronze"	
			hash["Bronze"] += 1 if report_card.project_score == "Bronze"	
			hash["Bronze"] += 1 if report_card.technical_score == "Bronze"
			hash["None"] += 1 if report_card.efficiency_score == "Bronze"
			hash["None"] += 1 if report_card.job_score == "None"
			hash["None"] += 1 if report_card.delivery_score == "None"	
			hash["None"] += 1 if report_card.project_score == "None"	
			hash["None"] += 1 if report_card.technical_score == "None"
			hash["None"] += 1 if report_card.efficiency_score == "None"
			hash["N/A"] += 1 if report_card.job_score == "N/A"
			hash["N/A"] += 1 if report_card.delivery_score == "N/A"	
			hash["N/A"] += 1 if report_card.project_score == "N/A"	
			hash["N/A"] += 1 if report_card.technical_score == "N/A"
			hash["N/A"] += 1 if report_card.efficiency_score == "N/A"
			medals_array = [hash["Gold"], hash["Silver"], hash["Bronze"], hash["None"], hash["N/A"]]
		end
		return medals_array
	end

end