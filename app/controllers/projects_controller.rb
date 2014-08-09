class ProjectsController < ApplicationController
	before_action :signed_in_user

	def new_project
    	if signed_in?
		   @project = Project.new
    	else
    	  render root_path
    	end
	end

	def create
		@project = Project.new(user_params)
    	if @project.save
    	  flash.now[:success] = "New Report Card Created!"
    	  redirect_to root_path
    	else
    	  render 'sign_up'
    	end
	end

	private

		def user_params
      		params.require(:project).permit(:project_name, :project_type, :delivery_date, :hours,
                                   :spoilage, :project_number, :sla_accuracy, :accuracy, :user_id)
    	end

end