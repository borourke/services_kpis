class Service < ActiveRecord::Base
	FIELD_OPTIONS = ["Gold", "Silver", "Bronze", "None", "N/A"]
	SCORE_FIELDS = ['job', 'delivery', 'project', 'technical', 'efficiency']
	
	def self.get_medal_count(current_user)
		report_cards = ReportCard.where(user_id: current_user.id)
		report_cards.each_with_object(Hash.new(0)) do |report_card, hash|
			FIELD_OPTIONS.each do |option|
				SCORE_FIELDS.each do |field|
					hash[option] += 1 if report_card.send("#{field}_score".to_sym) == option
				end
			end
		end
	end

	def self.get_all_time_medal_count
		report_cards = ReportCard.all
		report_cards.each_with_object(Hash.new(0)) do |report_card, hash|
			FIELD_OPTIONS.each do |option|
				SCORE_FIELDS.each do |field|
					hash[option] += 1 if report_card.send("#{field}_score".to_sym) == option
				end
			end
		end
	end

	def self.get_medals_by_month
		report_cards = ReportCard.all
		times = ReportCard.all.pluck(:created_at)
		{
			months: parse_time_to_months(times).uniq,
			medals_count: get_medal_count_by_month(report_cards, parse_time_to_months(times).uniq)
		}
		
	end

	private

		def self.parse_time_to_months(times)
			times.each_with_object([]) do |time, months|
				months << time.to_formatted_s(:month_and_year)
			end
		end

		def self.get_medal_count_by_month(report_cards, months)
			report_cards.each_with_object(Hash.new { |hash, key| hash[key] = [] }) do |report_card, counts|
				months.each_with_index do |month, index|
					FIELD_OPTIONS.each do |option|
						SCORE_FIELDS.each do |field|
							counts[option][index] = 0 if counts[option][index] == nil
							counts[option][index] += 1 if report_card.send("#{field}_score".to_sym) == option
						end
					end
				end
			end
		end

end