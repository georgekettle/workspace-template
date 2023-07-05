class WorkspaceUsersController < ApplicationController
    # GET /workspace_users/:id/edit
    def edit
        @workspace_user = WorkspaceUser.find(params[:id])
        authorize @workspace_user

        breadcrumb 'Home', @workspace_user.workspace
        breadcrumb 'Settings', settings_workspace_path(@workspace_user.workspace)
        breadcrumb 'Update Permissions', edit_workspace_user_path(@workspace_user)
    end

    # PATCH /workspace_users/:id
    def update
        @workspace_user = WorkspaceUser.find(params[:id])
        authorize @workspace_user

        if @workspace_user.update(workspace_user_params)
            redirect_to settings_workspace_path(@workspace_user.workspace), notice: "User updated."
        else
            breadcrumb 'Home', @workspace_user.workspace
            breadcrumb 'Settings', settings_workspace_path(@workspace_user.workspace)
            breadcrumb 'Update Permissions', settings_workspace_path(@workspace_user.workspace)

            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /workspace_users/:id
    def destroy
        @workspace_user = WorkspaceUser.find(params[:id])
        @workspace = @workspace_user.workspace
        authorize @workspace_user
        @workspace_user.destroy
        redirect_to settings_workspace_path(@workspace), notice: "User removed from workspace."
    end

    private

    def workspace_user_params
        params.require(:workspace_user).permit(:role)
    end
end
