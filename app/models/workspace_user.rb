class WorkspaceUser < ApplicationRecord
  belongs_to :user
  belongs_to :workspace

  validates :user_id, uniqueness: { scope: :workspace_id, message: 'already exists in this workspace' }
  validates :user_id, presence: true
  validates :workspace_id, presence: true

  enum role: { owner: 0, admin: 1, member: 2 }
end
