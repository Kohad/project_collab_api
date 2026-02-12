class MembershipPolicy < ApplicationPolicy

  def create?
    admin? || owner?
  end

  def destroy?
    admin? || owner?
  end
end
