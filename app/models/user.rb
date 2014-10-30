class User < ActiveRecord::Base
  has_many :report_cards, dependent: :destroy
  has_many :surveys
  before_save { self.email = email.downcase }
  attr_accessible :email
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :create

  FIELD_OPTIONS = ["Gold", "Silver", "Bronze", "None", "N/A"]
  SCORE_FIELDS = ['job', 'delivery', 'project', 'technical', 'efficiency']

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def project_chart_arrays
    projects = Project.where(id: self.report_cards.pluck(:project_id))

    {
      spoilage: create_spoilage_array(projects),
      sla_accuracy: create_sla_accuracy_array(projects),
      accuracy: create_accuracy_array(projects),
      difference: create_difference_array(projects),
      hours: create_hours_array(projects),
      complexity: create_complexity_hash(projects)
    }
  end

  def report_card_tables_arrays
    report_cards = ReportCard.where(user_id: self.id)

    {
      tables: create_report_card_tables_array(report_cards),
    }
  end

  def self.report_card_charts(user_id)
    if user_id == "all"
      report_cards = ReportCard.all
    else
      report_cards = ReportCard.where(user_id: user_id)
    end
    {
      gold: create_medal_count_array(report_cards, "Gold"),
      silver: create_medal_count_array(report_cards, "Silver"),
      bronze: create_medal_count_array(report_cards, "Bronze"),
      none: create_medal_count_array(report_cards, "None")
    }
  end
    

private

  def self.get_project_names(user_id)
    ReportCard.where(user_id: user_id).pluck(:project_name)
  end

  def create_report_card_tables_array(report_cards)
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

  def create_overall_medal_count_hash(report_cards)
    hash = Hash.new(0)
    report_cards.each do |report_card|
      hash["Gold"] += 1 if report_card.job_score == "Gold"
      hash["Gold"] += 1 if report_card.technical_score == "Gold"
      hash["Gold"] += 1 if report_card.project_score == "Gold"
      hash["Gold"] += 1 if report_card.efficiency_score == "Gold"
      hash["Silver"] += 1 if report_card.technical_score == "Silver"
      hash["Silver"] += 1 if report_card.job_score == "Silver"
      hash["Silver"] += 1 if report_card.project_score == "Silver"
      hash["Silver"] += 1 if report_card.efficiency_score == "Silver"
      hash["Bronze"] += 1 if report_card.project_score == "Bronze"
      hash["Bronze"] += 1 if report_card.job_score == "Bronze"
      hash["Bronze"] += 1 if report_card.technical_score == "Bronze"
      hash["Bronze"] += 1 if report_card.efficiency_score == "Bronze"
      hash["None"] += 1 if report_card.job_score == "None"
      hash["None"] += 1 if report_card.technical_score == "None"
      hash["None"] += 1 if report_card.project_score == "None"
      hash["None"] += 1 if report_card.efficiency_score == "None"
      hash["Not Applicable"] += 1 if report_card.job_score == "N/A"
      hash["Not Applicable"] += 1 if report_card.technical_score == "N/A"
      hash["Not Applicable"] += 1 if report_card.project_score == "N/A"
      hash["Not Applicable"] += 1 if report_card.efficiency_score == "N/A"
    end
    return hash
  end

  def self.create_medal_count_array(report_cards, medal)
    hash = Hash.new(0)
    report_cards.each do |report_card|
      hash["Job"] += 1 if report_card.job_score == medal
      hash["Technical"] += 1 if report_card.technical_score == medal
      hash["Project"] += 1 if report_card.project_score == medal
      hash["Efficiency"] += 1 if report_card.efficiency_score == medal
    end
    return [hash["Job"], hash["Technical"], hash["Project"], hash["Efficiency"]]
  end

  def create_spoilage_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.spoilage]
    end
  end

  def create_sla_accuracy_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.sla_accuracy]
    end
  end

  def create_accuracy_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.accuracy]
    end
  end

  def create_difference_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.accuracy - project.sla_accuracy]
    end
  end

  def create_hours_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.hours]
    end
  end

  def create_complexity_hash(projects)
    hash = Hash.new(0)
    projects.each do |project|
      hash["Low"] += 1 if project.complexity == "Low"
      hash["Medium"] += 1 if project.complexity == "Medium"
      hash["High"] += 1 if project.complexity == "High"
    end
    array = [["High", hash["High"]], ["Medium", hash["Medium"]], ["Low", hash["Low"]]]
  end

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
