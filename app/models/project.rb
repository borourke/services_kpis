class Project < ActiveRecord::Base
	belongs_to :clients
	has_many :report_cards
  validates :project_name, uniqueness: { case_sensitive: false }
  validates :project_name, :hours, :team, :delivery_date, :spoilage, :accuracy, :complexity, :project_number, presence: true

  def self.biz_data_project_chart_arrays
    projects = Project.where(team: 'Business Data')
    {
      spoilage: create_spoilage_array(projects),
      sla_accuracy: create_sla_accuracy_array(projects),
      accuracy: create_accuracy_array(projects),
      difference: create_difference_array(projects),
      hours: create_hours_array(projects),
      complexity: create_complexity_array(projects)
    }
  end

  def self.content_gen_project_chart_arrays
    projects = Project.where(team: 'Content Generation')
    {
      spoilage: create_spoilage_array(projects),
      sla_accuracy: create_sla_accuracy_array(projects),
      accuracy: create_accuracy_array(projects),
      difference: create_difference_array(projects),
      hours: create_hours_array(projects),
      complexity: create_complexity_array(projects)
    }
  end

  private

  def self.create_spoilage_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.spoilage]
    end
  end

  def self.create_sla_accuracy_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.sla_accuracy]
    end
  end

  def self.create_accuracy_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.accuracy]
    end
  end

  def self.create_difference_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.accuracy - project.sla_accuracy]
    end
  end

  def self.create_hours_array(projects)
    projects.each_with_object([]) do |project, memo|
      memo << [project.project_name, project.hours]
    end
  end

  def self.create_complexity_array(projects)
    hash = Hash.new(0)
    projects.each do |project|
      hash["Low"] += 1 if project.complexity == "Low"
      hash["Medium"] += 1 if project.complexity == "Medium"
      hash["High"] += 1 if project.complexity == "High"
    end
    array = [["High", hash["High"]], ["Medium", hash["Medium"]], ["Low", hash["Low"]]]
  end


end
