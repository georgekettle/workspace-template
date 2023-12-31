class WorkspacePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    user_is_member?
  end

  def create?
    true
  end

  def update?
    user_is_owner? || user_is_admin?
  end

  def destroy?
    user_is_owner?
  end

  def settings?
    user_is_owner? || user_is_admin?
  end

  def switch?
    user_is_member?
  end

  def transfer?
    user_is_owner?
  end

  private

  def user_is_owner?
    WorkspaceUser.find_by(user: user, workspace: record)&.owner?
  end

  def user_is_admin?
    WorkspaceUser.find_by(user: user, workspace: record)&.admin?
  end

  def user_is_member?
    WorkspaceUser.find_by(user: user, workspace: record).present?
  end
end
