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
  validates :password, length: { minimum: 6 }, on: :create

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
      hours: create_hours_array(projects)
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
      report_card_array = [report_card.cml_clean, report_card.cml_commented, report_card.instructions, report_card.tags, report_card.code_clean, report_card.code_advanced, report_card.code_utilized, report_card.complex_solution, report_card.delivery_docs, report_card.delivery_timely, report_card.communication, report_card.accuracy, report_card.spoilage, report_card.best_in_class]
      report_card_array.reject! { |x| x.include? "na"}
      points_acheived = report_card_array.reject { |x| x.include? "no" }
      memo << [project_name, ((points_acheived.length.to_f / report_card_array.length.to_f)*100).to_i ]
    end
  end

  def create_breakdown_report_card_hash(report_cards)
    breakdown_hash = Hash.new(0)
    report_cards.each_with_object(breakdown_hash) do |report_card, memo|
      breakdown_hash["Clean CML Total"] += 1 if (report_card.cml_clean != "no" && report_card.cml_clean != "na")
      breakdown_hash["Clean CML Out Of"] += 1 if (report_card.cml_clean != "na")
      breakdown_hash["Clean CML"] = ((breakdown_hash["Clean CML Total"].to_f / breakdown_hash["Clean CML Out Of"].to_f)*100).to_i

      breakdown_hash["Commented CML Total"] += 1 if (report_card.cml_commented != "no" && report_card.cml_commented != "na")
      breakdown_hash["Commented CML Out Of"] += 1 if (report_card.cml_commented != "na")
      breakdown_hash["Commented CML"] = ((breakdown_hash["Commented CML Total"].to_f / breakdown_hash["Commented CML Out Of"].to_f)*100).to_i

      breakdown_hash["Instructions Total"] += 1 if (report_card.instructions != "no" && report_card.instructions != "na")
      breakdown_hash["Instructions Out Of"] += 1 if (report_card.instructions != "na")
      breakdown_hash["Instructions"] = ((breakdown_hash["Instructions Total"].to_f / breakdown_hash["Instructions Out Of"].to_f)*100).to_i

      breakdown_hash["Tags Total"] += 1 if (report_card.tags != "no" && report_card.tags != "na")
      breakdown_hash["Tags Out Of"] += 1 if (report_card.tags != "na")
      breakdown_hash["Tags"] = ((breakdown_hash["Tags Total"].to_f / breakdown_hash["Tags Out Of"].to_f)*100).to_i

      breakdown_hash["Complex Problem Solving Total"] += 1 if (report_card.complex_solution != "no" && report_card.complex_solution != "na")
      breakdown_hash["Complex Problem Solving Out Of"] += 1 if (report_card.complex_solution != "na")
      breakdown_hash["Complex Problem Solving"] = ((breakdown_hash["Complex Problem Solving Total"].to_f / breakdown_hash["Complex Problem Solving Out Of"].to_f)*100).to_i

      breakdown_hash["Clean Code Total"] += 1 if (report_card.code_clean != "no" && report_card.code_clean != "na")
      breakdown_hash["Clean Code Out Of"] += 1 if (report_card.code_clean != "na")
      breakdown_hash["Clean Code"] = ((breakdown_hash["Clean Code Total"].to_f / breakdown_hash["Clean Code Out Of"].to_f)*100).to_i

      breakdown_hash["Advanced Code Total"] += 1 if (report_card.code_advanced != "no" && report_card.code_advanced != "na")
      breakdown_hash["Advanced Code Out Of"] += 1 if (report_card.code_advanced != "na")
      breakdown_hash["Advanced Code"] = ((breakdown_hash["Advanced Code Total"].to_f / breakdown_hash["Advanced Code Out Of"].to_f)*100).to_i

      breakdown_hash["Code Utilized Total"] += 1 if (report_card.code_utilized != "no" && report_card.code_utilized != "na")
      breakdown_hash["Code Utilized Out Of"] += 1 if (report_card.code_utilized != "na")
      breakdown_hash["Code Utilized"] = ((breakdown_hash["Code Utilized Total"].to_f / breakdown_hash["Code Utilized Out Of"].to_f)*100).to_i

      breakdown_hash["Delivery Docs Total"] += 1 if (report_card.delivery_docs != "no" && report_card.delivery_docs != "na")
      breakdown_hash["Delivery Docs Out Of"] += 1 if (report_card.delivery_docs != "na")
      breakdown_hash["Delivery Docs"] = ((breakdown_hash["Delivery Docs Total"].to_f / breakdown_hash["Delivery Docs Out Of"].to_f)*100).to_i

      breakdown_hash["Timely Delivery Total"] += 1 if (report_card.delivery_timely != "no" && report_card.delivery_timely != "na")
      breakdown_hash["Timely Delivery Out Of"] += 1 if (report_card.delivery_timely != "na")
      breakdown_hash["Timely Delivery"] = ((breakdown_hash["Timely Delivery Total"].to_f / breakdown_hash["Timely Delivery Out Of"].to_f)*100).to_i

      breakdown_hash["Communication Total"] += 1 if (report_card.communication != "no" && report_card.communication != "na")
      breakdown_hash["Communication Out Of"] += 1 if (report_card.communication != "na")
      breakdown_hash["Communication"] = ((breakdown_hash["Communication Total"].to_f / breakdown_hash["Communication Out Of"].to_f)*100).to_i

      breakdown_hash["Accuracy Total"] += 1 if (report_card.accuracy != "no" && report_card.accuracy != "na")
      breakdown_hash["Accuracy Out Of"] += 1 if (report_card.accuracy != "na")
      breakdown_hash["Accuracy"] = ((breakdown_hash["Accuracy Total"].to_f / breakdown_hash["Accuracy Out Of"].to_f)*100).to_i

      breakdown_hash["Spoilage Total"] += 1 if (report_card.spoilage != "no" && report_card.spoilage != "na")
      breakdown_hash["Spoilage Out Of"] += 1 if (report_card.spoilage != "na")
      breakdown_hash["Spoilage"] = ((breakdown_hash["Spoilage Total"].to_f / breakdown_hash["Spoilage Out Of"].to_f)*100).to_i

      breakdown_hash["Best In Class Total"] += 1 if (report_card.best_in_class != "no" && report_card.best_in_class != "na")
      breakdown_hash["Best In Class Out Of"] += 1 if (report_card.best_in_class != "na")
      breakdown_hash["Best In Class"] = ((breakdown_hash["Best In Class Total"].to_f / breakdown_hash["Best In Class Out Of"].to_f)*100).to_i
    end
    breakdown_hash.sort_by {|category, count| -count}
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

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
