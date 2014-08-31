AUTH_KEY = "af574018a6b7360b924c210c41d1f263e264cf83"
DOMAIN_BASE = "https://api.crowdflower.com"
TEMPLATE_JOB = "surveytemplate"
CrowdFlower::Job.connect! AUTH_KEY, DOMAIN_BASE

class CfApi

  def self.create_survey(params)
    title = params[:title]
    respondants = params[:respondants]
    prescreen_cml = params[:prescreen]
    survey_cml = params[:survey]
    job_owner = params[:job_owner]
    project_number = params[:project_number]
    payment_cents = params[:payment_cents]

    #Create job
    new_job = `curl -X POST 'https://crowdflower.com/jobs/#{TEMPLATE_JOB}/copy?all_units=true&key=#{AUTH_KEY}'`
    new_job = JSON.parse(new_job)
    job = CrowdFlower::Job.new(new_job["id"])

    #Update CML and title
    cml = '{% if prescreen = "yes" %} {{type}}' + prescreen_cml.to_s + '{% endif %}' + '{% if prescreen == "no" %}' + survey_cml.to_s + '{% endif %}' + '{% if prescreen == "dummy" %} {{type}} <cml:checkbox label="Check this box when you have completed this task" name="dummy" validates="required" gold="true"></cml:checkbox> {% endif %}'
    sleep 60
    job.update({:title => "#{title}"})
    job.update({:problem => cml})

    #First set the job settings
    job.update({:project_number => "#{project_number}"})
    job.update({:judgments_per_unit => (respondants.to_i)/100})
    job.update({:payment_cents => payment_cents})
    job_id = job.id
    `curl -X PUT --data-urlencode 'job[owner_email]=#{job_owner}' 'https://make.crowdflower.com/jobs/#{job_id}/settings/general.json?key=#{AUTH_KEY}'`
    return job_id
  end


end