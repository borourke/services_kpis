class Project < ActiveRecord::Base
	belongs_to :clients
	has_many :report_cards
  validates :project_name, uniqueness: { case_sensitive: false }
  validates :project_name, presence: true
  validates :hours, presence: true
  validates :team, presence: true
  validates :delivery_date, presence: true
  validates :spoilage, presence: true
  validates :accuracy, presence: true
  validates :complexity, presence: true
  validates :project_number, :presence => true

  def self.biz_data_project_chart_arrays
    projects = Project.where(team: 'Business Data')
    {
      spoilage: create_spoilage_array(projects),
      sla_accuracy: create_sla_accuracy_array(projects),
      accuracy: create_accuracy_array(projects),
      difference: create_difference_array(projects),
      hours: create_hours_array(projects)
    }
  end

  def self.content_gen_project_chart_arrays
    projects = Project.where(team: 'Content Generation')
    {
      spoilage: create_spoilage_array(projects),
      sla_accuracy: create_sla_accuracy_array(projects),
      accuracy: create_accuracy_array(projects),
      difference: create_difference_array(projects),
      hours: create_hours_array(projects)
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


end
