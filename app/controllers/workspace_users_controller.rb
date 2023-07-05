class WorkspaceUsersController < ApplicationController
    # DELETE /workspace_users/:id
    def destroy
        @workspace_user = WorkspaceUser.find(params[:id])
        @workspace = @workspace_user.workspace
        authorize @workspace_user
        @workspace_user.destroy
        redirect_to settings_workspace_path(@workspace), notice: "User removed from workspace."
    end
end
