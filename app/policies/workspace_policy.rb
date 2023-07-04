class WorkspacePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    true
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    WorkspaceUser.find_by(user: user, workspace: record)&.owner?
  end
end
