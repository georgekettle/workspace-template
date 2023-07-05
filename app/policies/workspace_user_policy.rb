class WorkspaceUserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user_is_owner? || user_is_admin?
  end

  def destroy?
    if record.member?
      user_is_admin? || user_is_owner?
    elsif record.admin?
      user_is_owner?
    elsif record.owner?
      false
    end
  end

  def update?
    if record.member?
      user_is_admin? || user_is_owner?
    elsif record.admin?
      user_is_owner?
    elsif record.owner?
      false
    end
  end

  def make_owner?
    user_is_owner?
  end

  private

  def user_is_owner?
    WorkspaceUser.find_by(user: user, workspace: record.workspace)&.owner?
  end

  def user_is_admin?
    WorkspaceUser.find_by(user: user, workspace: record.workspace)&.admin?
  end

  def user_is_member?
    WorkspaceUser.find_by(user: user, workspace: record.workspace)&.member?
  end
end
