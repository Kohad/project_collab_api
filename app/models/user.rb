class User < ApplicationRecord
  ROLES = %w[admin manager member].freeze

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: ROLES }

  # Role helper methods
  def admin?
    role == "admin"
  end

  def manager?
    role == "manager"
  end

  def member?
    role == "member"
  end
end
