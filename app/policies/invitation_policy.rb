class InvitationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user_is_owner? || user_is_admin?
  end

  private

  def user_is_owner?
    WorkspaceUser.find_by(user: user, workspace: record.workspace)&.owner?
  end

  def user_is_admin?
    WorkspaceUser.find_by(user: user, workspace: record.workspace)&.admin?
  end
end
