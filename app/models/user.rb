class User < ActiveRecord::Base
  has_many :report_cards, dependent: :destroy
  has_many :surveys
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

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
      difference: create_difference_array(projects)
    }
  end

  def report_card_chart_arrays
    report_cards = ReportCard.where(user_id: self.id)

    {
      count: create_counting_report_card_array(report_cards),
      breakdown: create_breakdown_report_card_hash(report_cards)
    }
  end
    

private

  def create_counting_report_card_array(report_cards)
    count_array = []
    report_cards.each_with_object(count_array) do |report_card, memo|
      project_name = Project.find(report_card.project_id).project_name
      count = report_card.report_card.split(", ").length
      memo << [project_name, count]
    end
  end

  def create_breakdown_report_card_hash(report_cards)
    breakdown_hash = Hash.new(0)
    report_cards.each_with_object(breakdown_hash) do |report_card, memo|
      report_card.report_card.split(", ").each do |category|
        breakdown_hash[category] += 1
      end
    end
    breakdown_hash.sort_by {|category, count| count}
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



  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
