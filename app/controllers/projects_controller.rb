class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy update_status]

	def index
		@projects = Project.includes(:creator).all
	end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    previous_stage = @project.current_status

    respond_to do |format|
      if @project.update(current_status: params[:project][:current_status])
        @project.interaction_logs.create!(user: current_user, previous_stage: previous_stage, current_stage: @project.current_status)

        format.html { redirect_to @project, notice: "Project Status was updated successfully." }
        format.turbo_stream
      else
        format.html { redirect_to @project, alert: "Error updating project status." }
        format.turbo_stream
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_path, status: :see_other, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :details)
  end
end
