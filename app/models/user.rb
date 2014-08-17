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

private

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
