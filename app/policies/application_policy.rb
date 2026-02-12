class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def admin?
    user&.admin?
  end

  def owner?
    record.respond_to?(:owner) && record.owner == user
  end
end
