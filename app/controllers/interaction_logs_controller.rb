class InteractionLogsController < ApplicationController
    before_action :set_project

    def create
      @comment = @project.interaction_logs.new(comment_params.merge(user: current_user))
  
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @project, notice: "Comment was successfully created." }
          format.turbo_stream
        else
          format.html { redirect_to @project, notice: "Error in creating comment" }
          format.turbo_stream
        end
      end
    end
  
    private
  
    def set_project
      @project = Project.find(params[:project_id])
    end
  
    def comment_params
      params.require(:interaction_log).permit(:feedback)
    end
end
