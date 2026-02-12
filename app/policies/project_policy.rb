class ProjectPolicy < ApplicationPolicy

  def create?
    admin? || user.manager?
  end

  def update?
    return true if admin?
    return true if owner?
    editor_member?
  end

  def destroy?
    admin? || owner?
  end

  def show?
    admin? || owner? || member_of_project?
  end

  private

  def member_of_project?
    ProjectMembership.exists?(user: user, project: record)
  end

  def editor_member?
    ProjectMembership.exists?(user: user, project: record, role: "editor")
  end
end
