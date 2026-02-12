class MembershipsController < ApplicationController
  before_action :set_project

  # POST /projects/:id/members
  def create
    authorize!(@project, :create)

    membership = @project.project_memberships.new(membership_params)

    if membership.save
      render json: membership, status: :created
    else
      render json: { errors: membership.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:id/members/:user_id
  def destroy
    authorize!(@project, :destroy)

    membership = @project.project_memberships.find_by(user_id: params[:user_id])

    return render json: { error: "Not Found" }, status: :not_found unless membership

    membership.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
    return render json: { error: "Not Found" }, status: :not_found unless @project
  end

  def membership_params
    params.require(:membership).permit(:user_id, :role)
  end
end
