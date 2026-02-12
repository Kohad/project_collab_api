class User < ApplicationRecord
  ROLES = %w[admin manager member].freeze

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: ROLES }

  has_many :owned_projects, class_name: "Project", foreign_key: "owner_id", dependent: :destroy

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
