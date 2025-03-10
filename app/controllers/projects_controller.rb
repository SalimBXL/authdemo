class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    fresh_when etag: @project
  end

  def create
    project = Project.create!(project_params)
    redirect_to project
  end

  def edit
    @project = Project.find(params[:id])
    fresh_when etag: @project
  end

  def destroy
  end

  private
    def project_params
      params.require(:project).permit(:name, :description, :user)
    end
end
