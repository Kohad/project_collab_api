class ProjectMembership < ApplicationRecord
  ROLES = %w[viewer editor].freeze

  belongs_to :user
  belongs_to :project

  validates :role, presence: true, inclusion: { in: ROLES }
end
