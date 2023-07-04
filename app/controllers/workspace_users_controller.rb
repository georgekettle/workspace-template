class WorkspaceUsersController < ApplicationController
  before_action :set_workspace, only: %i[new create]

  # GET /workspaces/1/workspace_users/new
  def new
    @workspace_user = @workspace.workspace_users.new
    authorize @workspace_user

    breadcrumb "Home", workspace_path(@workspace)
    breadcrumb "Settings", settings_workspace_path(@workspace) if request.referer.include?("settings")
    breadcrumb "Invite Members", new_workspace_workspace_user_path(@workspace)
  end

  # POST /workspaces/1/workspace_users
  def create
  end

  private

  def set_workspace
    @workspace = Workspace.find(params[:workspace_id])
  end
end
