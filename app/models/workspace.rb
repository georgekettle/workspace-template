class Workspace < ApplicationRecord
    has_many :workspace_users, dependent: :destroy
    
    validates :name, presence: true
    # length max 20 chars
    validates :name, length: { maximum: 20 }
    
    def owner
        workspace_users.find_by(role: 'owner').user
    end
end
