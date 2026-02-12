class ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]

  # POST /projects
  def create
    project = Project.new(project_params)
    project.owner = current_user

    authorize!(project, :create)

    if project.save
      render json: project, status: :created
    else
      render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /projects
  def index
    projects =
      if current_user.admin?
        Project.all
      else
        Project
          .joins("LEFT JOIN project_memberships ON project_memberships.project_id = projects.id")
          .where("projects.owner_id = :user_id OR project_memberships.user_id = :user_id", user_id: current_user.id)
          .distinct
      end

    render json: projects, status: :ok
  end

  # PUT /projects/:id
  def update
    authorize!(@project, :update)

    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:id
  def destroy
    authorize!(@project, :destroy)

    @project.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])
    return render json: { error: "Not Found" }, status: :not_found unless @project
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
