AUTH_KEY = "af574018a6b7360b924c210c41d1f263e264cf83"
DOMAIN_BASE = "https://api.crowdflower.com"
TEMPLATE_JOB = "surveytemplateforapp"
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
    #cml = '<% if prescreen = "yes" %>' + prescreen_cml.to_s + '<% else %>' + survey_cml.to_s + '<% endif %>'
    cml = prescreen_cml
    job.update({:title => "#{title}"})
    job.update({:cml => '<div class="well">
  
  <cml:radios label="23. What is the Number 1 reason you would abandon your online/mobile shopping cart when holiday shopping?" name="why_abondon123" validates="required">
    <cml:radio label="Messages/offers are not personalized based on my previous purchase history"></cml:radio>
    <cml:radio label="Catalog doesn&#x2019;t show real-time list of products and prices"></cml:radio>
    <cml:radio label="Information about shipping costs and delivery times is not provided before checkout"></cml:radio>
    <cml:radio label="Difficult to view/click through site on mobile"></cml:radio>
    <cml:radio label="Required to login and fill out long forms before checkout"></cml:radio>
    <cml:radio label="Pages and images take too long to load"></cml:radio>
  </cml:radios>
  
</div>'})


    #First set the job settings
    job.update({:project_number => "#{project_number}"})
    job.update({:minimum_requirements => {:priority => 1, :skill_scores => {:level_1_contributors => 1}, :min_score => 1, :priority => 1}.to_json}) if respondants.to_i > 1000 #Open to level 1 contributors if there are more than 1000 respondants desired
    job.update({:minimum_requirements => {:priority => 1, :skill_scores => {:level_2_contributors => 1}, :min_score => 1, :priority => 1}.to_json}) if respondants.to_i <= 1000 #Open to level 2 contributors if there are less than or exactly 1000 respondants desired
    job.update({:judgments_per_unit => respondants})
    job.update({:payment_cents => payment_cents})
    job_id = job.id
    `curl -X PUT --data-urlencode 'job[owner_email]=#{job_owner}' 'https://make.crowdflower.com/jobs/#{job_id}/settings/general.json?key=#{AUTH_KEY}'`
    return job_id
  end


end